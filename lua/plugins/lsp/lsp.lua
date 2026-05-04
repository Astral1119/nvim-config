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
        -- Proper types for vim.uv (libuv bindings)
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
      },
    },
  },

  {
    'neovim/nvim-lspconfig',
    dependencies = { 'saghen/blink.cmp' },
    config = function()
      require('config.plugin-configs.lsp-config')

      -- Advertise blink.cmp completion capabilities to every server.
      -- nvim-lspconfig registers default cmd/filetypes/root_markers for known
      -- servers, so we only need to specify settings we actually want to change.
      vim.lsp.config('*', {
        capabilities = require('blink.cmp').get_lsp_capabilities(),
      })

      -- Lua
      -- lazydev.nvim handles workspace library injection, so we only need
      -- to suppress telemetry here.
      vim.lsp.config('lua_ls', {
        settings = {
          Lua = {
            telemetry = { enable = false },
          },
        },
      })

      -- Python: ruff handles linting + formatting, pyright handles type checking.
      -- Tell pyright to stay out of ruff's lane so diagnostics don't double up.
      vim.lsp.config('pyright', {
        settings = {
          pyright = {
            disableOrganizeImports = true,
          },
          python = {
            analysis = {
              ignore = { '*' },
            },
          },
        },
      })

      -- Rust: run clippy instead of check on save for better diagnostics.
      vim.lsp.config('rust_analyzer', {
        settings = {
          ['rust-analyzer'] = {
            check = { command = 'clippy' },
          },
        },
      })

      -- Markdown Oxide: custom on_attach for CodeLens + Daily note command.
      vim.lsp.config('markdown_oxide', {
        on_attach = oxide.on_attach,
        settings = {
          keyword_pattern = [[\(\k\| \|\/\|#\)\+]],
        },
      })

      -- ruff, ts_ls, clangd, texlab use nvim-lspconfig defaults with no overrides.

      -- Lattice (custom language, not in Mason or nvim-lspconfig)
      vim.lsp.config('lattice', {
        cmd = { 'lattice', 'lsp' },
        filetypes = { 'lattice' },
        root_markers = { '.git', 'Cargo.toml', '.lattice', 'lattice.workspace' },
        single_file_support = true,
      })
      vim.lsp.enable('lattice')

      -- Enable servers explicitly. Mason installs the binaries; this tells
      -- Neovim to actually start each server when its filetype is opened.
      vim.lsp.enable({
        'lua_ls',
        'ruff',
        'pyright',
        'rust_analyzer',
        'ts_ls',
        'clangd',
        'texlab',
        'markdown_oxide',
        'lattice_lsp',
      })

      -- Mason: installs/updates binaries. automatic_enable = false because we
      -- manage the enable list above -- no silent auto-enabling.
      require('mason').setup()
      require('mason-lspconfig').setup({
        ensure_installed = {
          'lua_ls', 'pyright', 'rust_analyzer',
          'ts_ls', 'clangd', 'texlab',
        },
        automatic_installation = true,
        automatic_enable = false,
      })
    end,
  },
}
