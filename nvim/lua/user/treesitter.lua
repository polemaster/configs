require('Comment').setup {
  pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook(),
}

local keymaps = require('user.keymaps').treesitter

require('nvim-treesitter.configs').setup {
  ensure_installed = { 'c', 'cpp', 'lua', 'python', 'vimdoc', 'vim', 'html', 'css', 'javascript', 'r',
  'query', 'markdown', 'markdown_inline', 'make', 'bash' },

  auto_install = false,

  -- context_commentstring = {
  --   enable = true,
  --   enable_autocmd = false,
  -- },

  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false
  },

  indent = { enable = true }, -- Experimental

  incremental_selection = {
    enable = true,
    keymaps = keymaps.incremental_selection
  },

  textobjects = {
    select = {
      enable = true,
      lookahead = true,
      keymaps = keymaps.selection,
    },
    move = {
      enable = true,
      set_jumps = true, -- whether to set jumps in the jumplist
      goto_next_start = keymaps.motion.next_start,
      goto_next_end = keymaps.motion.next_end,
      goto_previous_start = keymaps.motion.previous_start,
      goto_previous_end = keymaps.motion.previous_end,
    }
  },

  matchup = { enable = true },

  autotag = { enable = true },
}
