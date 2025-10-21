local oxide = require('plugins.lsp.oxide')

return {
  "williamboman/mason.nvim",
  "williamboman/mason-lspconfig.nvim",
  { 'j-hui/fidget.nvim', opts = {} },

  {
    "folke/lazydev.nvim",
    ft = "lua",
    opts = {
      library = {
        -- Add any optional libraries for LazyDev here
      },
    },
  },

  {
    'neovim/nvim-lspconfig',
    dependencies = {
      'saghen/blink.cmp',
    },
    config = function()
      require('config.plugin-configs.lsp-config')

      local capabilities = require('blink.cmp').get_lsp_capabilities()

      vim.lsp.config('*', {
        capabilities = capabilities,
        workspace = {
          didChangeWatchedFiles = {
            dynamicRegistration = true,
          },
        },
      })

      -- Lua
      vim.lsp.config('lua_ls', {
        cmd = { 'lua-language-server' },
        filetypes = { 'lua' },
        root_markers = { '.luarc.json', '.luarc.jsonc', '.git' },
        settings = {
          Lua = {
            runtime = { version = "LuaJIT" },
            workspace = {
              library = vim.api.nvim_get_runtime_file("", true),
              checkThirdParty = false,
            },
            telemetry = { enable = false },
          }
        }
      })

      -- Python
      vim.lsp.config('ruff', {
        init_options = {
          settings = {
            -- Ruff language server settings go here
          }
        }
      })

      -- Rust
      vim.lsp.config('rust_analyzer', {
        cmd = { 'rust-analyzer' },
        filetypes = { 'rust' },
        root_markers = { 'Cargo.toml', '.git' },
        settings = {
          ['rust-analyzer'] = {
            checkOnSave = {
              command = "clippy",
            }
          }
        }
      })

      -- Markdown Oxide
      vim.lsp.config('markdown_oxide', {
        cmd = { 'markdown-oxide' },
        filetypes = { 'markdown' },
        on_attach = oxide.on_attach,
        settings = {
          keyword_pattern = [[\(\k\| \|\/\|#\)\+]]
        }
      })

      -- Enable LSPs
      vim.lsp.enable({ 'lua_ls', 'ruff', 'rust_analyzer', 'markdown_oxide' })

      -- Mason setup
      require('mason').setup()
      require('mason-lspconfig').setup({
        ensure_installed = { 'lua_ls', 'ruff', 'pyright', 'rust_analyzer' },
        automatic_installation = true,
        automatic_enable = true,
      })
    end
  }
}
