return {
  {
    'lewis6991/gitsigns.nvim',
    event = 'BufReadPre',
    opts = {
      on_attach = function(bufnr)
        local gs = require('gitsigns')
        local function map(mode, l, r, desc)
          vim.keymap.set(mode, l, r, { buffer = bufnr, desc = desc })
        end

        -- Hunk navigation (respects diff mode)
        map('n', ']h', function()
          if vim.wo.diff then vim.cmd.normal({ ']c', bang = true })
          else gs.nav_hunk('next') end
        end, 'Next hunk')
        map('n', '[h', function()
          if vim.wo.diff then vim.cmd.normal({ '[c', bang = true })
          else gs.nav_hunk('prev') end
        end, 'Prev hunk')

        -- Stage / reset
        map('n', '<leader>hs', gs.stage_hunk, 'Stage hunk')
        map('n', '<leader>hr', gs.reset_hunk, 'Reset hunk')
        map('v', '<leader>hs', function()
          gs.stage_hunk({ vim.fn.line('.'), vim.fn.line('v') })
        end, 'Stage hunk')
        map('v', '<leader>hr', function()
          gs.reset_hunk({ vim.fn.line('.'), vim.fn.line('v') })
        end, 'Reset hunk')
        map('n', '<leader>hS', gs.stage_buffer, 'Stage buffer')
        map('n', '<leader>hR', gs.reset_buffer, 'Reset buffer')
        map('n', '<leader>hu', gs.undo_stage_hunk, 'Undo stage hunk')

        -- Inspect
        map('n', '<leader>hp', gs.preview_hunk, 'Preview hunk')
        map('n', '<leader>hb', function() gs.blame_line({ full = true }) end, 'Blame line')
        map('n', '<leader>hd', gs.diffthis, 'Diff this')

        -- Text object: ih = inside hunk
        map({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>', 'Inside hunk')
      end,
    },
  },
}
