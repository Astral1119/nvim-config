-- lua/config/plugin-configs/lsp-config.lua

-- Diagnostic navigation (global, works without LSP e.g. for treesitter diagnostics)
vim.keymap.set('n', '<localleader>e', vim.diagnostic.open_float, { desc = 'Show diagnostic' })
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Previous diagnostic' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Next diagnostic' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Diagnostic quickfix list' })

-- Neovim 0.11 sets these automatically on LspAttach, so we only add what's
-- not covered by defaults or Snacks picker:
--
--   Navigation (Snacks picker):  gd, gD, gr, gI, gy
--   Hover / signature:           K, <C-s> (insert)
--   Refactor:                    grn (rename), gra (code action)
--   Symbols:                     gO (document symbols), <leader>ss, <leader>sS

-- <space>f is handled by conform.nvim (with LSP fallback)

-- Inlay hints: enable globally on LspAttach for servers that support them
vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if client and client:supports_method('textDocument/inlayHint') then
      vim.lsp.inlay_hint.enable(true, { bufnr = args.buf })
    end
  end,
})

-- Toggle inlay hints with <leader>ih
vim.keymap.set('n', '<leader>ih', function()
  vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
end, { desc = 'Toggle inlay hints' })
