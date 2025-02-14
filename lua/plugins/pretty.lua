return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = false,
    priority = 9000,
    config = function()
      vim.cmd([[colorscheme catppuccin]])
    end,
  },
  { "nvim-tree/nvim-web-devicons", lazy = true },
  { "stevearc/dressing.nvim", event = "VeryLazy" },
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = {
    },
    dependencies = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
      }
  }
}
