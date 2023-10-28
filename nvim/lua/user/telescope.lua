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
        ['<C-s>'] = actions.select_horizontal,
        ["<esc>"] = actions.close,
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
  extensions = {
    file_browser = {
      -- layout_strategy = 'center',
      -- theme = "ivy",
      hijack_netrw = true,
      initial_mode = 'normal',
      previewer = false,
    },
  },
}

-- Enable telescope-fzf-native
require('telescope').load_extension('fzf')

require("telescope").load_extension('file_browser')
