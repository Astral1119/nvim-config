return {
  {
    'stevearc/conform.nvim',
    event = 'BufWritePre',
    cmd = 'ConformInfo',
    keys = {
      {
        '<space>f',
        function()
          require('conform').format({ async = true, lsp_format = 'fallback' })
        end,
        desc = 'Format buffer',
      },
    },
    opts = {
      formatters_by_ft = {
        lua        = { 'stylua' },
        python     = { 'ruff_format', 'ruff_organize_imports' },
        javascript = { 'prettier' },
        typescript = { 'prettier' },
        javascriptreact = { 'prettier' },
        typescriptreact = { 'prettier' },
        json       = { 'prettier' },
        yaml       = { 'prettier' },
        html       = { 'prettier' },
        css        = { 'prettier' },
        markdown   = { 'prettier' },
        c          = { 'clang_format' },
        cpp        = { 'clang_format' },
        -- rust: rust_analyzer wraps rustfmt, so lsp_format fallback handles it
      },
    },
  },
}
