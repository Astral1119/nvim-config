-- init.lua

-- needs to be loaded before lazy
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- lazy plugin manager
require("config.lazy")
require("config.options")

-- KEYBINDINGS

-- get rid of search highlights with <Esc>
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>', { desc = 'Clear highlights', silent = true })

-- get out of term mode
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- split navigation
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- keeping the system and vim clipboards separate for now
-- nice to have both ctrl + v and p for different clipboards
-- may eventually replace with some sort of clipboard manager
--[[
vim.schedule(function()
  vim.opt.clipboard = 'unnamedplus'
end)
--]]

-- copy to system clipboard
vim.keymap.set("v", "<leader>c", "\"+y", { desc = "Copy to clipboard", silent = true })

-- cut to system clipboard
vim.keymap.set("v", "<leader>x", "\"+ygvx", { desc = "Cut to clipboard", silent = true })

-- changing copilot autocomplete key from <Tab> to <Right>
vim.keymap.set('i', '<Right>', 'copilot#Accept("\\<CR>")', {
  expr = true,
  replace_keycodes = false
})
vim.g.copilot_no_tab_map = true


vim.g.markdown_fenced_languages = {'python', 'cpp'}


