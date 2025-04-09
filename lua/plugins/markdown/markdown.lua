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
      },
    }
  },
  { 'jakewvincent/mkdnflow.nvim' },
}
