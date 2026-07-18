-- lua/plugins/lean.lua
-- Lean 4 theorem prover support (LSP + infoview + unicode abbreviations).
-- The language server ships with the toolchain (elan -> lean/lake) and is
-- launched per-project by lean.nvim; ensure `lean`/`lake` are on PATH
-- (handled by ELAN_HOME/bin in ~/.config/zsh/.zshrc).
--
-- Config is via `vim.g.lean_config`, set in `init` (before the plugin loads).
-- `require("lean").setup` is deprecated and removed in lean.nvim v2026.9.1;
-- the plugin now auto-activates on Lean files, so no setup() call is needed.
return {
  {
    'Julian/lean.nvim',
    ft = 'lean',
    dependencies = {
      'neovim/nvim-lspconfig',
      'nvim-lua/plenary.nvim',
    },
    init = function()
      vim.g.lean_config = {
        lsp = {},        -- start the Lean language server on lean files
        mappings = true, -- lean.nvim's default <localleader> keymaps (infoview, etc.)
      }
    end,
  },
}
