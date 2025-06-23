-- https://www.josean.com/posts/neovim-linting-and-formatting
-- also, there is none-ls which replaces null-ls

-- formatting
require("conform").setup({
    formatters_by_ft = {
        lua = { "stylua" },
        python = { "isort", "black" },
        -- python = { "isort", "ruff_format" },
        -- python = { "ruff_format" },
        -- python = function(bufnr)
        --     if require("conform").get_formatter_info("ruff_format", bufnr).available then
        --         return { "ruff_format" }
        --     else
        --         return { "isort", "black" }
        --     end
        -- end,
        javascript = { "prettierd" },
        typescript = { "prettierd" },
        javascriptreact = { "prettierd" },
        typescriptreact = { "prettierd" },
        css = { "prettierd" },
        html = { "prettierd" },
        json = { "prettierd" },
        markdown = { "prettierd" },
        cpp = { "clang_format" }, -- to change style: ~/.local/share/nvim/mason/bin/clang-format --style GNU --dump-config > .clang_format
        c = { "clang_format" },
    },
    -- format_on_save = {
    --     lsp_fallback = false,
    --     async = false,
    --     -- timeout_ms = 500,
    -- },
    format_after_save = {
        lsp_format = "never",
    },
    notify_on_error = true,
})

-- linting
-- need to install linters via Mason or package manager
require("lint").linters_by_ft = {
    javascript = { "eslint_d" },
    typescript = { "eslint_d" },
    python = { "ruff" },
    c = { "cpplint" },
    cpp = { "cpplint" },
    -- python = { 'pylint' },
    -- python = { 'flake8' },
    -- python = { 'mypy' },
}

-- Eslint returns error/warning if this code is not included (and it needs to be older version)
local eslint = require("lint").linters.eslint_d

eslint.args = {
    "--no-warn-ignored", -- <-- this is the key argument
    "--format",
    "json",
    "--stdin",
    "--stdin-filename",
    function()
        return vim.api.nvim_buf_get_name(0)
    end,
}

local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

-- vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
vim.api.nvim_create_autocmd({ "BufWritePost" }, {
    group = lint_augroup,
    callback = function()
        require("lint").try_lint()
    end,
})
