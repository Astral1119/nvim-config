vim.g.mapleader = " "
vim.g.maplocalleader = "\\"
vim.g.molten_auto_open_output = true
vim.g.molten_copy_output = true

vim.cmd("set number relativenumber")
vim.cmd("set expandtab")
vim.cmd("set tabstop=2")
vim.cmd("set softtabstop=2")
vim.cmd("set shiftwidth=2")
vim.cmd("set linebreak")

vim.g.markdown_fenced_languages = {'python', 'cpp'}

vim.g.vimwiki_global_ext = 0

require("config.lazy")

-- require'lspconfig'.harper_ls.setup{}

-- Key Mappings
vim.keymap.set("v", "<leader>c", "\"+y", { desc = "Copy to clipboard", silent = true })

-- Provide a command to create a blank new Python notebook
-- note: the metadata is needed for Jupytext to understand how to parse the notebook.
-- if you use another language than Python, you should change it in the template.
local default_notebook = [[
  {
    "cells": [
     {
      "cell_type": "markdown",
      "metadata": {},
      "source": [
        ""
      ]
     }
    ],
    "metadata": {
     "kernelspec": {
      "display_name": "Python 3",
      "language": "python",
      "name": "python3"
     },
     "language_info": {
      "codemirror_mode": {
        "name": "ipython"
      },
      "file_extension": ".py",
      "mimetype": "text/x-python",
      "name": "python",
      "nbconvert_exporter": "python",
      "pygments_lexer": "ipython3"
     }
    },
    "nbformat": 4,
    "nbformat_minor": 5
  }
]]

local function new_notebook(filename)
  local path = filename .. ".ipynb"
  local file = io.open(path, "w")
  if file then
    file:write(default_notebook)
    file:close()
    vim.cmd("edit " .. path)
  else
    print("Error: Could not open new notebook file for writing.")
  end
end

vim.api.nvim_create_user_command('NewNotebook', function(opts)
  new_notebook(opts.args)
end, {
  nargs = 1,
  complete = 'file'
})


vim.keymap.set('i', '<Right>', 'copilot#Accept("\\<CR>")', {
  expr = true,
  replace_keycodes = false
})
vim.g.copilot_no_tab_map = true


vim.api.nvim_set_keymap(
  'n', 
  '<leader>z', 
  [[:!zathura %:r.pdf &<CR> &<CR>]], 
  { noremap = true, silent = true }
)

-- Setting up checkbox toggling
vim.keymap.set("n", "<leader>tt", ":lua require('toggle-checkbox').toggle()<CR>")

-- Clear search highlights
vim.keymap.set("n", "<esc>", ":noh <CR>")
