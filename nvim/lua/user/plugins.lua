-- lazy options:
-- https://github.com/folke/lazy.nvim?tab=readme-ov-file#-plugin-spec

return {
    -- LSP
    -- If one has little RAM, they can install lsp-timeout.nvim
    -- Needed package npm for pyright
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            -- Automatically install LSPs to stdpath for neovim
            { "williamboman/mason.nvim", config = true },
            "williamboman/mason-lspconfig.nvim",
            "WhoIsSethDaniel/mason-tool-installer.nvim",

            -- Useful plugin for configuring neovim
            "folke/neodev.nvim",

            -- Needed for lsp completion icons
            "onsails/lspkind.nvim",
        },
    },

    -- Autocompletion
    {
        "hrsh7th/nvim-cmp",
        event = { "InsertEnter", "CmdlineEnter" }, -- https://github.com/hrsh7th/nvim-cmp/wiki/Example-mappings
        dependencies = {
            -- Snippet Engine & its associated nvim-cmp source
            "L3MON4D3/LuaSnip",
            "saadparwaiz1/cmp_luasnip",

            -- Adds LSP completion capabilities
            "hrsh7th/cmp-nvim-lsp",

            -- Add other useful completion options
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-cmdline",

            -- Adds a number of user-friendly snippets
            "rafamadriz/friendly-snippets",
        },
    },

    -- Useful plugin to show you pending keybinds.
    { "folke/which-key.nvim", opts = {} },

    -- Git
    "tpope/vim-fugitive",
    "tpope/vim-rhubarb",
    "lewis6991/gitsigns.nvim",

    -- Colorscheme
    -- { "catppuccin/nvim",      lazy = false, name = 'catppuccin', priority = 1000 },
    { "folke/tokyonight.nvim", lazy = false, priority = 1000 },
    { "navarasu/onedark.nvim", lazy = false, priority = 1000 },

    -- session manager (remembers opened files etc.)
    "rmagatti/auto-session",

    {
        "nvim-lualine/lualine.nvim",
        lazy = false,
        -- sections = {
        --  lualine_c = { require('auto-session.lib').current_session_name }
        -- }
    },

    {
        -- Add indentation guides even on blank lines
        "lukas-reineke/indent-blankline.nvim",
        -- See `:help indent_blankline.txt`
        main = "ibl",
        opts = {},
        -- lazy = false,
    },

    -- Telescope
    -- Needed package ripgrep (install it via package manager) for live grep and package fd (for what?)
    {
        "nvim-telescope/telescope.nvim",
        branch = "0.1.x",
        dependencies = {
            "nvim-lua/plenary.nvim",
            -- fzf-native is a fuzzy finder and enables searches with: ',^,$,|
            -- it requires 'make' program
            {
                "nvim-telescope/telescope-fzf-native.nvim",
                build = "make",
                cond = function()
                    return vim.fn.executable("make") == 1
                end,
            },
        },
    },

    -- Commenting
    {
        "numToStr/Comment.nvim",
        lazy = false,
    },

    -- Treesitter
    {
        -- Highlight, edit, and navigate code
        "nvim-treesitter/nvim-treesitter",
        dependencies = {
            "nvim-treesitter/nvim-treesitter-textobjects",
            "JoosepAlviste/nvim-ts-context-commentstring",
            "nvim-treesitter/nvim-treesitter-context", -- used to stick function to the top if it is above the screen view
            {
                "andymass/vim-matchup",
                setup = function()
                    vim.g.matchup_matchparen_offscreen = { method = "popup" }
                end,
            },
            "windwp/nvim-ts-autotag",
        },
        build = ":TSUpdate",
    },

    -- Autopairs (brackets and quotes)
    {
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        opts = {}, -- this is equalent to setup({}) function
    },

    -- File tree
    "nvim-tree/nvim-tree.lua",
    "nvim-tree/nvim-web-devicons",

    -- Terminal
    { "akinsho/toggleterm.nvim", version = "*" },

    -- Tabs (buffers)
    -- There is also akinsho/bufferline.nvim plugin and willothy/nvim-cokeline
    -- {'akinsho/bufferline.nvim', version = "*"},
    "romgrk/barbar.nvim",

    -- Notifications
    "rcarriga/nvim-notify",
    "j-hui/fidget.nvim",

    -- Improves UI
    { "stevearc/dressing.nvim", event = "VeryLazy" },

    -- Hex editing
    { "RaafatTurki/hex.nvim", opts = {} },

    -- for debugging startup time
    {
        "dstein64/vim-startuptime",
        cmd = "StartupTime",
        init = function()
            vim.g.startuptime_tries = 10
        end,
    },

    {
        "kylechui/nvim-surround",
        version = "*",
        event = "VeryLazy",
        opts = {},
    },

    -- debugging
    "mfussenegger/nvim-dap",
    "rcarriga/nvim-dap-ui",
    "mfussenegger/nvim-dap-python", -- requires debugpy
    "jay-babu/mason-nvim-dap.nvim",
    "theHamsta/nvim-dap-virtual-text", -- to-do: configure

    -- formatting and linting (replacing null-ls)
    {
        "stevearc/conform.nvim",
        event = { "BufReadPre", "BufNewFile" },
    },
    {
        "mfussenegger/nvim-lint",
        event = { "BufReadPre", "BufNewFile" },
    },

    -- pretty diagnostics and other
    "folke/trouble.nvim",

    -- startup - dashboard
    {
        "nvimdev/dashboard-nvim",
        event = "VimEnter",
    },
}
