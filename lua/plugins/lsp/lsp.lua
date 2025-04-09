local oxide = require('plugins.lsp.oxide')

return {
  "williamboman/mason.nvim",
  "williamboman/mason-lspconfig.nvim",

  {
    "folke/lazydev.nvim",
    ft = "lua", -- only load on lua files
    opts = {
      library = {
        -- See the configuration section for more details
        -- Load luvit types when the `vim.uv` word is found
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
      },
    },
  },

  {
    'neovim/nvim-lspconfig',
    dependencies = {
      'saghen/blink.cmp',
    },

    opts = {
      sources = {
        default = { "lazydev", "lsp", "path", "snippets", "buffer" },
        providers = {
          lazydev = {
            name = "LazyDev",
            module = "lazydev.integrations.blink",
            -- make lazydev completions top priority (see `:h blink.cmp`)
            score_offset = 100,
          },
          lsp = {
            name = "nvim_lsp",
            option = {
              markdown_oxide = {
                keyword_pattern = [[\(\k\| \|\/\|#\)\+]]
              }
            }
          },
        },
      }
    },

    config = function()

      -- load keymaps and other configs
      require('config.plugin-configs.lsp-config')

      local capabilities = require('blink.cmp').get_lsp_capabilities()

      require("lspconfig").markdown_oxide.setup({
        capabilities = vim.tbl_deep_extend(
          'force',
          capabilities,
          {
            workspace = {
              didChangeWatchedFiles = {
                dynamicRegistration = true,
              },
            },
          }
        ),
        on_attach = oxide.on_attach,
      })

      require('mason').setup()
      require('mason-lspconfig').setup({
        ensure_installed = {
          'lua_ls',
          'pyright',
          'rust_analyzer',
        },
        automatic_installation = true,
      })

      require('mason-lspconfig').setup_handlers({
        function(server_name)
          local opts = {
            capabilities = capabilities,
          }

          if server_name == "lua_ls" then
            opts.settings = {
              Lua = {
                runtime = {
                  version = "LuaJIT",
                },
                workspace = {
                  library = vim.api.nvim_get_runtime_file("", true),
                  checkThirdParty = false,
                },
                telemetry = {
                  enable = false,
                },
              },
            }
          elseif server_name == "pyright" then
            opts.settings = {
              python = {
                analysis = {
                  typeCheckingMode = "basic",
                  autoImportCompletions = true,
                  useLibraryCodeForTypes = true,
                },
              },
            }
          elseif server_name == "rust_analyzer" then
            opts.settings = {
              ['rust-analyzer'] = {
                checkOnSave = {
                  command = "clippy",
                },
              },
            }
          end

          require('lspconfig')[server_name].setup(opts)
        end,
      })
    end
  }
}

