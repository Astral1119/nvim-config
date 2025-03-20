-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Setup lazy.nvim
require("lazy").setup({
  spec = {
    { import = "plugins" },
    -- Add oil.nvim configuration inside Lazy
    {
      "stevearc/oil.nvim",
      config = function()
        require("oil").setup({
          default_file_explorer = false,
          experimental_watch_for_changes = true,
          buf_options = {
            modifiable = true,
          },
        })
      end
    }
  },
  install = { colorscheme = { "habamax" } },
  checker = { enabled = true },
})

-- load oil
require("oil").setup({
  default_file_explorer = false,
})

-- load noice
require("noice").setup({
  lsp = {
    -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
    override = {
      ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
      ["vim.lsp.util.stylize_markdown"] = true,
      --["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
    },
  },
  -- you can enable a preset for easier configuration
  presets = {
    bottom_search = true, -- use a classic bottom cmdline for search
    command_palette = true, -- position the cmdline and popupmenu together
    long_message_to_split = true, -- long messages will be sent to a split
    inc_rename = false, -- enables an input dialog for inc-rename.nvim
    lsp_doc_border = false, -- add a border to hover docs and signature help
  },
  views = {
    cmdline_popup = {
      size = {
        width = "auto",
        height = "auto",
      },
      win_options = {
        winblend = 0, -- Make it transparent
        winhighlight = "NormalFloat:Normal,FloatBorder:Normal",
      },
    },
  },
})


-- load mason
require("mason").setup()
require('mason-lspconfig').setup({
  ensure_installed = {'pyright', 'clangd', 'texlab'},
  handlers = {
    function(server_name)
      require('lspconfig')[server_name].setup({})
    end,
  },
})

