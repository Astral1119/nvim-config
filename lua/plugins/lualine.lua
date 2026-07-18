return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" }, -- optional icons
  config = function()
    -- livery palette when a Look is applied; moonfly-derived auto otherwise.
    local livery_ok, livery = pcall(require, "livery")
    require("lualine").setup {
      options = {
        theme = (livery_ok and livery.lualine_theme()) or "auto",
        globalstatus = true,
        section_separators = "",
        component_separators = "",
      },
      sections = {
        lualine_a = { "mode" },
        lualine_b = { "branch", "diff", "diagnostics" },
        lualine_c = { -- word count
          "filename",
          {
            function()
              local wc = vim.fn.wordcount()
              local count = wc.visual_words > 0 and wc.visual_words or wc.words
              return count .. " WC"
            end,
            icon = "",
          },
        },
        lualine_x = { "encoding", "fileformat", "filetype" },
        lualine_y = { "progress" },
        lualine_z = { "location" },
      },
    }
  end,
}
