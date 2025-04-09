-- config/options.lua
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"
vim.g.molten_auto_open_output = true
vim.g.molten_copy_output = true

local opt = vim.opt

opt.undofile = true

-- times taken from kickstart.nvim
opt.updatetime = 250
opt.timeoutlen = 300


-- line numbers
opt.relativenumber = true
opt.number = true
opt.cursorline = true
opt.signcolumn = 'yes:1'

opt.mouse = 'a' -- enable mouse support

-- SEARCH CONFIGURATION
opt.grepformat = '%f:%l:%c:%m' -- grep format
opt.grepprg = 'rg --vimgrep' -- grep program

-- ignore case unless search pattern contains upper case
opt.ignorecase = true
opt.smartcase = true

-- splits
opt.splitright = true
opt.splitbelow = true

opt.list = true
opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

opt.fillchars = {
  foldopen = "",
  foldclose = "",
  fold = " ",
  foldsep = " ",
  diff = "╱",
  eob = " ",
}

opt.inccommand = 'nosplit'

opt.linebreak = true
-- opt.breakindent = true
opt.expandtab = true
opt.smartindent = true
opt.tabstop = 2
-- opt.softtabstop = 2
opt.shiftwidth = 2
