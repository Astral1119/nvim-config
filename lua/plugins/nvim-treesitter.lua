return {
  'nvim-treesitter/nvim-treesitter',
  build = ':TSUpdate',
  dependencies = {
    'nvim-treesitter/nvim-treesitter-textobjects',
  },
  opts = function()
    return {
      -- Your Treesitter configuration here
      priority = 500,
      highlight = { enable = true }, 
      ensure_installed = { "cpp", "c", "lua", "vim", "vimdoc", "query", "python", "markdown", "markdown_inline", "html", "latex", "sql" },
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
    require('nvim-treesitter.configs').setup(opts)
  end,
}
