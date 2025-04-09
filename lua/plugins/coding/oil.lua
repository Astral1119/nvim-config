return {
  "stevearc/oil.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  lazy = false,
  config = function()
    require("oil").setup({
      default_file_explorer = false,
      experimental_watch_for_changes = true,
      buf_options = {
        modifiable = true,
      },
    })
  end
}

