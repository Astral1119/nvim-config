return {
  {
    "scottmckendry/cyberdream.nvim",
    lazy = false,
    config = function()
      require("cyberdream").setup({
        transparent = true,
        styles = {
          sidebars = "transparent",
        },
      })
      -- vim.cmd("colorscheme cyberdream")
    end,
  },
  {
    "bluz71/vim-moonfly-colors",
    name = "moonfly",
    lazy = false,
    priority = 1000,
    config = function()
      vim.g.moonflyTransparent = true
      vim.g.moonflyCursorColor = true
      vim.g.moonflyNormalFloat = true
      vim.g.moonflyUnderlineMatchParen = true
      vim.g.moonflyVirtualTextColor = true
      vim.g.moonflyWinSeparator = 2
      vim.opt.fillchars = { horiz = '━', horizup = '┻', horizdown = '┳', vert = '┃', vertleft = '┫', vertright = '┣', verthoriz = '╋', }

      vim.cmd("colorscheme moonfly")
    end
  }
}
