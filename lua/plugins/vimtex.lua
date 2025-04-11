-- load zathura with <leader>lz
-- useful for viewing tex files
vim.api.nvim_set_keymap(
  'n',
  '<leader>lz',
  [[:!zathura %:r.pdf &<CR> &<CR>]],
  { noremap = true, silent = true }
)

return {
  {
    "lervag/vimtex",
    lazy = false,     -- we don't want to lazy load VimTeX
    -- tag = "v2.15", -- uncomment to pin to a specific release
    init = function()
      -- VimTeX configuration goes here, e.g.
      vim.g.vimtex_view_method = "zathura"
    end
  }
}
