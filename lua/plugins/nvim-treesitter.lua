return {
  'nvim-treesitter/nvim-treesitter',
  build = ':TSUpdate',
  dependencies = {
    'nvim-treesitter/nvim-treesitter-textobjects',
  },
  opts = function()
    return {
      priority = 500,
      ensure_installed = { "cpp", "c", "lua", "vim", "vimdoc", "query", "python", "markdown", "markdown_inline", "html", "latex", "sql", "gsheets" },

      highlight = { enable = true },

      indent = { enable = true },

      textobjects = {
        move = {
          enable = true,
          set_jumps = false, -- you can change this if you want.
          goto_next_start = {
            --- ... other keymaps
            ["]b"] = { query = "@code_cell.inner", desc = "next code block" },
          },
          goto_previous_start = {
            --- ... other keymaps
            ["[b"] = { query = "@code_cell.inner", desc = "previous code block" },
          },
        },
        select = {
          enable = true,
          lookahead = true, -- you can change this if you want
          keymaps = {
            --- ... other keymaps
            ["ib"] = { query = "@code_cell.inner", desc = "in block" },
            ["ab"] = { query = "@code_cell.outer", desc = "around block" },
          },
        },
        swap = { -- Swap only works with code blocks that are under the same
          -- markdown header
          enable = true,
          swap_next = {
            --- ... other keymap
            ["<leader>sbl"] = "@code_cell.outer",
          },
          swap_previous = {
            --- ... other keymap
            ["<leader>sbh"] = "@code_cell.outer",
          },
        },
      }
    }
  end,
  config = function(_, opts)

    vim.filetype.add({
      extension = {
        gse = "gsheets",
        gsf = "gsheets",
        gsheets = "gsheets",
      },
    })

    local parser_config = require("nvim-treesitter.parsers").get_parser_configs()

    parser_config.gsheets = {
      install_info = {
        url = "https://github.com/Astral1119/tree-sitter-gsheets",
        files = { "src/parser.c" }, -- add "scanner.c" if the grammar has one
        branch = "main", -- or the correct branch
      },
      filetype = "gsheets",
    }
    require('nvim-treesitter.configs').setup(opts)
  end,
}
