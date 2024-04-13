-- Here is a more advanced example where we pass configuration
-- options to `gitsigns.nvim`. This is equivalent to the following Lua:
--    require('gitsigns').setup({ ... })
--
-- See `:help gitsigns` to understand what the configuration keys do
return {
  { -- Adds git related signs to the gutter, as well as utilities for managing changes
    'lewis6991/gitsigns.nvim',
    config = function()
      local gitsigns = require('gitsigns')

      local function map(mode, l, r, opts)
        opts = opts or {}
        opts.buffer = bufnr
        vim.keymap.set(mode, l, r, opts)
      end
  
      -- Navigation
      map('n', ']c', function()
        if vim.wo.diff then
          vim.cmd.normal({']c', bang = true})
        else
          gitsigns.nav_hunk('next')
        end
      end)
  
      map('n', '[c', function()
        if vim.wo.diff then
          vim.cmd.normal({'[c', bang = true})
        else
          gitsigns.nav_hunk('prev')
        end
      end)
  
      -- Actions
      map('n', '<leader>hs', gitsigns.stage_hunk, { desc = '[S]tage Hunk'})
      map('n', '<leader>hr', gitsigns.reset_hunk, { desc = '[R]set Hunk'})
      map('v', '<leader>hs', function() gitsigns.stage_hunk {vim.fn.line('.'), vim.fn.line('v')} end, { desc = '[S]tage Hunk'})
      map('v', '<leader>hr', function() gitsigns.reset_hunk {vim.fn.line('.'), vim.fn.line('v')} end, { desc = '[S]tage Hunk'})
      map('n', '<leader>hS', gitsigns.stage_buffer, { desc = '[S]tage Buffer'})
      map('n', '<leader>hu', gitsigns.undo_stage_hunk, { desc = '[U]ndo stage Hunk'})
      map('n', '<leader>hR', gitsigns.reset_buffer, { desc = '[R]set Buffer'})
      map('n', '<leader>hp', gitsigns.preview_hunk, { desc = '[P]review Hunk'})
      map('n', '<leader>hb', function() gitsigns.blame_line{full=true} end, { desc = '[B]lame Line'})
      map('n', '<leader>tb', gitsigns.toggle_current_line_blame, { desc = '[T]oggle Current Line Blame'})
      map('n', '<leader>hd', gitsigns.diffthis, { desc = '[D]iff This'})
      map('n', '<leader>hD', function() gitsigns.diffthis('~') end, { desc = '[D]iff This ~'})
      map('n', '<leader>td', gitsigns.toggle_deleted, { desc = '[T]oggle Deleted'})
  
      -- Text object
      map({'o', 'x'}, 'ih', ':<C-U>Gitsigns select_hunk<CR>')
    end,
    opts = {
      signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
      },
      signcolumn = true,  -- Toggle with `:Gitsigns toggle_signs`
      numhl      = false, -- Toggle with `:Gitsigns toggle_numhl`
      linehl     = false, -- Toggle with `:Gitsigns toggle_linehl`
      word_diff  = false, -- Toggle with `:Gitsigns toggle_word_diff`
      watch_gitdir = {
        follow_files = true
      },
      auto_attach = true,
      attach_to_untracked = false,
      current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
      current_line_blame_opts = {
        virt_text = true,
        virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
        delay = 1000,
        ignore_whitespace = false,
        virt_text_priority = 100,
      },
      current_line_blame_formatter = '<author>, <author_time:%Y-%m-%d> - <summary>',
      current_line_blame_formatter_opts = {
        relative_time = false,
      },
      sign_priority = 6,
      update_debounce = 100,
      status_formatter = nil, -- Use default
      max_file_length = 40000, -- Disable if file is longer than this (in lines)
      preview_config = {
        -- Options passed to nvim_open_win
        border = 'single',
        style = 'minimal',
        relative = 'cursor',
        row = 0,
        col = 1
      },
    },
  }
}
-- vim: ts=2 sts=2 sw=2 et
