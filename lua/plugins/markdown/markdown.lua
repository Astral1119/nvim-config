return {
  {
    -- currently prefer this over 'MeanderingProgrammer/render-markdown.nvim'
    -- https://github.com/OXY2DEV/markview.nvim/wiki
    "OXY2DEV/markview.nvim",
    ft = "markdown",

    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons"
    },
    opts = {
      latex = {
        enable = true,
      },
      preview = {
        enable = true,
        debounce = 100,
        hybrid_modes = { "n", "i", "v" },
        linewise_hybrid_mode = true,
      },
      markdown = {
        list_items = {
          enable = false,
        }
      },
    }
  },
  { 'jakewvincent/mkdnflow.nvim' },
}
