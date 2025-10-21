return { -- might set this back up, right now interferes with snacks image
  --[[
  {
    "3rd/image.nvim",
    build = false, -- prevent building the rock manually
    opts = {
      processor = "magick_cli",
    },
    config = function()
      require("image").setup({
        backend = "kitty",
        processor = "magick_cli", -- can be "magick_rock" if desired
        integrations = {
          markdown = {
            enabled = true,
            clear_in_insert_mode = false,
            download_remote_images = true,
            only_render_image_at_cursor = false,
            only_render_image_at_cursor_mode = "popup",
            floating_windows = false,
            filetypes = { "markdown", "vimwiki" },
          },
          neorg = {
            enabled = true,
            filetypes = { "norg" },
          },
          typst = {
            enabled = true,
            filetypes = { "typst" },
          },
          html = {
            enabled = false,
          },
          css = {
            enabled = false,
          },
        },
        max_width = nil,
        max_height = nil,
        max_width_window_percentage = nil,
        max_height_window_percentage = 50,
        window_overlap_clear_enabled = true,
        window_overlap_clear_ft_ignore = {
          "cmp_menu", "cmp_docs", "snacks_notif", "scrollview", "scrollview_sign",
        },
        editor_only_render_when_focused = false,
        tmux_show_only_in_active_window = false,
        hijack_file_patterns = {
          "*.png", "*.jpg", "*.jpeg", "*.gif", "*.webp", "*.avif",
        },
        kitty_method = "normal",
      })
    end,
  },
  --]]
  {
    "HakonHarnes/img-clip.nvim",
    event = "VeryLazy",
    opts = {
      -- add options here
      -- or leave it empty to use the default settings
    },
    keys = {
      -- suggested keymap
      { "<leader>p", "<cmd>PasteImage<cr>", desc = "Paste image from system clipboard" },
    },
  }
}
