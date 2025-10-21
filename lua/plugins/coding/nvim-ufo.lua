return {
  {
    'kevinhwang91/nvim-ufo',
    dependencies = {
      'kevinhwang91/promise-async',
    },
    event = 'BufReadPost',
    config = function()
      vim.o.foldcolumn = '1' -- '0' is not bad
      vim.o.foldlevel = 99 -- Large fold level to keep all folds open initially
      vim.o.foldlevelstart = 99
      vim.o.foldenable = true

      -- Keymaps for opening/closing all folds
      vim.keymap.set('n', 'zR', require('ufo').openAllFolds, { desc = 'Open all folds' })
      vim.keymap.set('n', 'zM', require('ufo').closeAllFolds, { desc = 'Close all folds' })


      require('ufo').setup({
        provider_selector = function(bufnr, filetype, buftype)
        return { 'treesitter', 'indent' }
        end,
      })

    end,
  },
}
