return {
  {
    "lervag/vimtex",
    lazy = false,     -- we don't want to lazy load VimTeX
    -- tag = "v2.15", -- uncomment to pin to a specific release
    init = function()
      -- VimTeX configuration goes here, e.g.
      vim.g.vimtex_compiler_method = 'tectonic'
      vim.g.vimtex_compiler_wait = 1
      vim.g.vimtex_view_method = 'skim'
      vim.g.vimtex_view_automatic = 1

      -- to reload, \ll
      -- there might be a way to make it work with :w but oh well
    end
  }
}
