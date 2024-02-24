local actions = require 'telescope.actions'

require('telescope').setup {
  defaults = {
    mappings = {
      i = {
        ['<C-u>'] = false,
        ['<C-d>'] = false,
        ['<C-p>'] = actions.cycle_history_prev,
        ['<C-n>'] = actions.cycle_history_next,
        ['<C-j>'] = actions.move_selection_next,
        ['<C-k>'] = actions.move_selection_previous,
        -- vertical split: ctrl+v
        ['<C-s>'] = actions.select_horizontal, -- normal shortcut for it is ctrl+x
        ['<esc>'] = actions.close,
      },
    },
    file_ignore_patterns = { "^venv/" },
    -- prompt_prefix = '',
    -- selection_caret = '↪ ',   -- can change if I find a suitable character
    -- entry_prefix = '',
    -- initial_mode = 'insert'
  },
  pickers = {
    find_files = {
      previewer = false,
      -- layout_strategy = 'center', -- doesn't do anything if theme is enabled
      theme = 'dropdown',
      disable_devicons = true,
      hidden = true,
    }
  },
}

-- Enable telescope-fzf-native
require('telescope').load_extension('fzf')

require('telescope').load_extension('notify')
