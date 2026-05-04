-- Code agent: codecompanion.nvim with Claude (Anthropic)
-- Requires ANTHROPIC_API_KEY to be set in your environment.
return {
  {
    'olimorris/codecompanion.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-treesitter/nvim-treesitter',
    },
    opts = {
      adapters = {
        anthropic = function()
          return require('codecompanion.adapters').extend('anthropic', {
            schema = {
              model = { default = 'claude-sonnet-4-6' },
            },
          })
        end,
      },
      strategies = {
        chat   = { adapter = 'anthropic' },
        inline = { adapter = 'anthropic' },
        agent  = { adapter = 'anthropic' },
      },
      display = {
        chat = {
          -- Open chat in a vertical split rather than a new tab
          window = { layout = 'vertical', width = 0.35 },
        },
      },
    },
    keys = {
      { '<leader>ac', '<cmd>CodeCompanionChat Toggle<cr>', desc = 'Toggle AI chat', mode = { 'n', 'v' } },
      { '<leader>aa', '<cmd>CodeCompanionActions<cr>',     desc = 'AI actions',     mode = { 'n', 'v' } },
      { '<leader>ai', '<cmd>CodeCompanion<cr>',            desc = 'AI inline',      mode = { 'n', 'v' } },
      { '<leader>aA', '<cmd>CodeCompanionChat Add<cr>',    desc = 'Add to AI chat', mode = 'v' },
    },
  },
}
