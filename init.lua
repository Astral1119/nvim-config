-- init.lua

-- needs to be loaded before lazy
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- ensure cargo/rustup binaries are on PATH
-- (needed when Neovim is launched from a GUI that doesn't source shell profiles)
for _, dir in ipairs({ "$HOME/.cargo/bin", "$HOME/.dev/.cargo/bin" }) do
  local cargo_bin = vim.fn.expand(dir)
  if vim.fn.isdirectory(cargo_bin) == 1 and not string.find(vim.env.PATH or "", cargo_bin, 1, true) then
    vim.env.PATH = cargo_bin .. ":" .. vim.env.PATH
  end
end

-- lazy plugin manager
require("config.lazy")
require("config.options")

-- Lattice Formula Steps plugin
vim.opt.rtp:prepend(vim.fn.expand("~/sandbox/current/lattice/editors/neovim"))
require("lattice.formula_steps").setup({ keybind = "<leader>ls" })

-- KEYBINDINGS

-- get rid of search highlights with <Esc>
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>', { desc = 'Clear highlights', silent = true })

-- get out of term mode
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- split navigation
vim.keymap.set('n', '<leader>j', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<leader>k', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

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


vim.g.markdown_fenced_languages = {'python', 'cpp'}

vim.g.python3_host_prog=vim.fn.expand("~/.pyenv/versions/neovim/bin/python3")

vim.filetype.add({ extension = { mdx = "mdx", lat = "lattice" } })

