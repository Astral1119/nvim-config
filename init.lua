-- VIM OPTION SETTINGS

vim.g.mapleader = " "
vim.g.maplocalleader = "\\"
vim.g.molten_auto_open_output = true
vim.g.molten_copy_output = true

vim.opt.relativenumber = true
vim.opt.cursorline = true

vim.opt.mouse = 'a'

vim.opt.breakindent = true
vim.opt.undofile = true

vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.linebreak = true

vim.opt.signcolumn = 'yes:1'

-- times taken from kickstart.nvim
vim.opt.updatetime = 250
vim.opt.timeoutlen = 300

vim.opt.splitright = true
vim.opt.splitbelow = true

vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

vim.opt.inccommand = 'split'

-- VIM KEYMAP SETTINGS

-- get rid of search highlights
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>', { desc = 'Clear highlights', silent = true })

-- split navigation
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- copy to system clipboard
vim.keymap.set("v", "<leader>c", "\"+y", { desc = "Copy to clipboard", silent = true })


-- kickstart highlights yanked text
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- changing copilot autocomplete key from <Tab> to <Right>
vim.keymap.set('i', '<Right>', 'copilot#Accept("\\<CR>")', {
  expr = true,
  replace_keycodes = false
})
vim.g.copilot_no_tab_map = true

-- open zathura with <leader>z
-- useful for viewing tex files
vim.api.nvim_set_keymap(
  'n', 
  '<leader>z', 
  [[:!zathura %:r.pdf &<CR> &<CR>]], 
  { noremap = true, silent = true }
)

-- toggle markdown checkbox with <leader>tt
vim.keymap.set("n", "<leader>tt", ":lua require('toggle-checkbox').toggle()<CR>")


vim.cmd("set expandtab")
vim.cmd("set tabstop=2")
vim.cmd("set softtabstop=2")
vim.cmd("set shiftwidth=2")
vim.cmd("set linebreak")

vim.g.markdown_fenced_languages = {'python', 'cpp'}

require("config.lazy")

-- require'lspconfig'.harper_ls.setup{}


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


-- load mason
require("mason").setup()
