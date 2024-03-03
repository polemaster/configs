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
      mappings = {
        i = {
          ["<C-up>"] = function(prompt_bufnr)
            local current_picker =
              require("telescope.actions.state").get_current_picker(prompt_bufnr)
            -- cwd is only set if passed as telescope option
            local cwd = current_picker.cwd and tostring(current_picker.cwd)
              or vim.loop.cwd()
            local parent_dir = vim.fs.dirname(cwd)

            require("telescope.actions").close(prompt_bufnr)
            require("telescope.builtin").find_files {
              prompt_title = vim.fs.basename(parent_dir),
              cwd = parent_dir,
            }
          end,
        },
		},
    }
  },
}

-- Extensions
require('telescope').load_extension('fzf')
require('telescope').load_extension('notify')
require('telescope').load_extension('session-lens')
