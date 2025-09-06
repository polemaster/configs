-- Modify this table to configure LSP servers (useful setting: filetypes = {})
-- LSP servers configuration: https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
-- Language specific plugins: https://github.com/neovim/nvim-lspconfig/wiki/Language-specific-plugins

-- Setup neovim lua configuration
require("neodev").setup({
    library = { plugins = { "nvim-dap-ui" }, types = true },
})

-- nvim-cmp supports additional completion capabilities, so broadcast that to servers
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

-- Mason settings
require("mason").setup({
    ui = {
        border = "rounded", -- same values as nvim_open_win()
        icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗",
        },
    },
})

local mason_lspconfig = require("mason-lspconfig")

-- attach LSPs to buffers and set up capabilities (autocompletion)
mason_lspconfig.setup()

mason_lspconfig.setup_handlers({
    function(server_name)
        require("lspconfig")[server_name].setup({
            capabilities = capabilities,
            on_attach = require("user.keymaps").lsp_on_attach, -- Keymaps are set in keymaps.lua file
        })
    end,
})

-- is it really needed? can't we use ensure_installed in mason instead?
require("mason-tool-installer").setup({
    ensure_installed = {
        -- LSPs:
        "pyright",
        "clangd",
        {
            "lua-language-server",
            workspace = { checkThirdParty = false },
            telemetry = { enable = false },
        },
        "bash-language-server",
        "html-lsp",
        "css-lsp",
        "css-variables-language-server",
        "typescript-language-server",
        "angular-language-server",
        "tailwindcss",
        "eslint-lsp",

        -- Formatters:
        "prettierd", -- prettier formatter (html, css, ...)
        "stylua", -- lua formatter
        "isort", -- python formatter
        "black", -- python formatter
        "ruff", -- python formatter & linter
        "clang-format", -- C/C++ formatter

        -- Linters:
        "pylint", -- python linter
        "mypy", -- python linter
        "flake8", -- python linter
        { "eslint_d", version = "13.1.2" }, -- js linter
        "shellcheck", -- bash linter
        "cpplint", -- C/C++ linter
        "htmlhint", -- HTML linter
        "stylelint", -- CSS & SCSS linter

        -- Debuggers:
        "debugpy",
    },
})

-- CSSLS doesn't recognize @apply rule from tailwind so we need to ignore it
require("lspconfig").cssls.setup({
    settings = {
        css = {
            lint = {
                unknownAtRules = "ignore",
            },
        },
    },
})

-- Set how diagnostics is to be displayed
vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
    border = "single",
})

vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
    border = "single",
})

-- more general (not only LSP)
vim.diagnostic.config({
    virtual_text = false,
    signs = {
        text = {
            [vim.diagnostic.severity.ERROR] = " ",
            [vim.diagnostic.severity.WARN] = " ",
            [vim.diagnostic.severity.HINT] = "󰠠 ",
            [vim.diagnostic.severity.INFO] = " ",
        },
    },
    underline = true,
    update_in_insert = false,
    severity_sort = false,
    float = { border = "single", header = "" },
})
