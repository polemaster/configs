require('Comment').setup {
  pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook(),
}

require('nvim-treesitter.configs').setup {
  ensure_installed = { 'c', 'cpp', 'lua', 'python', 'vimdoc', 'vim', 'html', 'css', 'javascript', 'r',
  'query', 'markdown', 'markdown_inline', 'make', 'bash' },

  auto_install = false,

  context_commentstring = {
    enable = true,
    enable_autocmd = false,
  },

  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false
  },

  indent = { enable = true }, -- Experimental

  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = '<c-space>',
      node_incremental = '<c-space>',
      scope_incremental = false,
      node_decremental = '<bs>',
    },
  },

  textobjects = {
    select = {
      enable = true,
      lookahead = true,
      keymaps = {
        ["ai"] = { query = "@conditional.outer", desc = "Select outer part of a conditional" },
        ["ii"] = { query = "@conditional.inner", desc = "Select inner part of a conditional" },

        ["al"] = { query = "@loop.outer", desc = "Select outer part of a loop" },
        ["il"] = { query = "@loop.inner", desc = "Select inner part of a loop" },

        ["af"] = { query = "@function.outer", desc = "Select outer part of a method/function definition" },
        ["if"] = { query = "@function.inner", desc = "Select inner part of a method/function definition" },

        -- ["ac"] = { query = "@class.outer", desc = "Select outer part of a class" },
        -- ["ic"] = { query = "@class.inner", desc = "Select inner part of a class" },
      },
    },
    move = {
      enable = true,
      set_jumps = true, -- whether to set jumps in the jumplist
      goto_next_start = {
        ["]f"] = { query = "@function.outer", desc = "Next method/function def start" },
        -- ["]c"] = { query = "@class.outer", desc = "Next class start" },
        ["]c"] = { query = "@comment.outer", desc = "Next comment start" },
        ["]i"] = { query = "@conditional.outer", desc = "Next conditional start" },
        ["]l"] = { query = "@loop.outer", desc = "Next loop start" },

        ["]z"] = { query = "@fold", query_group = "folds", desc = "Next fold" },
      },
      goto_next_end = {
        ["]F"] = { query = "@function.outer", desc = "Next method/function def end" },
        -- ["]C"] = { query = "@class.outer", desc = "Next class end" },
        ["]I"] = { query = "@conditional.outer", desc = "Next conditional end" },
        ["]L"] = { query = "@loop.outer", desc = "Next loop end" },
      },
      goto_previous_start = {
        ["[f"] = { query = "@function.outer", desc = "Prev method/function def start" },
        -- ["[c"] = { query = "@class.outer", desc = "Prev class start" },
        ["[c"] = { query = "@comment.outer", desc = "Prev comment start" },
        ["[i"] = { query = "@conditional.outer", desc = "Prev conditional start" },
        ["[l"] = { query = "@loop.outer", desc = "Prev loop start" },
      },
      goto_previous_end = {
        ["[F"] = { query = "@function.outer", desc = "Prev method/function def end" },
        -- ["[C"] = { query = "@class.outer", desc = "Prev class end" },
        ["[I"] = { query = "@conditional.outer", desc = "Prev conditional end" },
        ["[L"] = { query = "@loop.outer", desc = "Prev loop end" },
      },
    }
  },

  matchup = { enable = true },

  autotag = { enable = true },
}
