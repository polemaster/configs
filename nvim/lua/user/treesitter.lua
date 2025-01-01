local keymaps = require("user.keymaps").treesitter

require("ts_context_commentstring").setup({
    enable_autocmd = false,
})

require("nvim-treesitter.configs").setup({
    ensure_installed = {
        "c",
        "cpp",
        "lua",
        "python",
        "vimdoc",
        "vim",
        "html",
        "css",
        "javascript",
        "typescript",
        "query",
        "markdown",
        "markdown_inline",
        "make",
        "bash",
        "csv",
        "diff",
        "java",
        "json",
        "latex",
        "norg",
        "php",
        "regex",
        "sql",
        "xml",
    },

    auto_install = false,

    highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
    },

    indent = { enable = true }, -- Experimental

    incremental_selection = {
        enable = true,
        keymaps = keymaps.incremental_selection,
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
        },
        lsp_interop = {
            enable = true,
            border = "none",
            floating_preview_opts = {},
            peek_definition_code = keymaps.peek_definition_code,
        },
    },

    matchup = { enable = true },
})
