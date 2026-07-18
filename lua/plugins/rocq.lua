-- lua/plugins/rocq.lua
-- Rocq Prover (formerly Coq) support: LSP-driven proof checking with a live
-- goals/info panel -- the analog of the lean.nvim setup.
--
-- The toolchain lives in the opam 'rocq' switch (OPAMROOT=~/.dev/.opam); the
-- `coq-lsp` binary must be on PATH (handled by the opam env hook in
-- ~/.config/zsh/.zshrc). coq-lsp.nvim relies on Coqtail only for .v filetype
-- detection, syntax highlighting and basic ftplugin -- it does NOT use
-- Coqtail's interactive proof commands, since coq-lsp checks the whole
-- document continuously and shows goals at the cursor.
--
-- Note on .v: Neovim maps *.v to Verilog by default. The filetype rule below
-- demotes obvious Verilog back to `verilog` and treats everything else as
-- `coq`. If a file is misdetected, `:set ft=verilog` (or `=coq`) overrides it.
return {
  -- Syntax / ftdetect / indent for .v files (filetype = coq).
  -- Coqtail's own interactive mappings are disabled; coq-lsp drives interaction.
  {
    'whonore/Coqtail',
    ft = 'coq',
    init = function()
      vim.g.coqtail_nomap = 1  -- don't bind Coqtail's normal-mode proof maps
      vim.g.coqtail_noimap = 1 -- ... nor its insert-mode maps

      -- Content-aware *.v dispatch so lazy's `ft = 'coq'` trigger fires and
      -- Verilog still works.
      vim.filetype.add({
        extension = {
          v = function(_, bufnr)
            for _, line in ipairs(vim.api.nvim_buf_get_lines(bufnr, 0, 100, false)) do
              if line:match('^%s*module%s') or line:match('endmodule')
                or line:match('`timescale') or line:match('^%s*always%s*@') then
                return 'verilog'
              end
              if line:match('^%s*Require%s') or line:match('^%s*From%s')
                or line:match('^%s*Theorem%s') or line:match('^%s*Lemma%s')
                or line:match('^%s*Proof%s*%.') or line:match('^%s*Inductive%s')
                or line:match('^%s*Definition%s') or line:match('^%s*Qed%s*%.') then
                return 'coq'
              end
            end
            return 'coq' -- ambiguous/empty: this is a proof machine
          end,
        },
      })
    end,
  },

  -- The LSP client + cursor-driven goals/info panel.
  {
    'tomtomjhj/coq-lsp.nvim',
    ft = 'coq',
    dependencies = {
      'whonore/Coqtail',
      'neovim/nvim-lspconfig',
    },
    config = function()
      require('coq-lsp').setup({
        coq_lsp_nvim = {
          info_panel_mode = 'tab',        -- one shared goals panel per tab
          info_panel_sticky_close = true, -- stays closed once you close it
        },
        lsp = {
          init_options = {
            -- Keep Check/Compute/Search output in the goals/info panel.
            show_notices_as_diagnostics = false,
            messages_follow_goal = true,
          },
          on_attach = function(_, bufnr)
            local map = function(lhs, rhs, desc)
              vim.keymap.set('n', lhs, rhs, { buffer = bufnr, desc = desc })
            end
            -- Open the goals/info panel once; it then follows the cursor.
            map('<localleader>i', '<cmd>CoqLsp open_info_panel<cr>', 'Rocq: goals/info panel')
            map('<localleader>s', '<cmd>CoqLsp saveVo<cr>',          'Rocq: save .vo')
            map('<localleader>r', '<cmd>lsp restart coq_lsp<cr>',    'Rocq: restart server')
          end,
        },
      })
    end,
  },
}
