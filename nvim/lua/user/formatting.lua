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
        javascript = { "prettier" },
        typescript = { "prettier" },
        css = { "prettier" },
        html = { "prettier" },
        json = { "prettier" },
        markdown = { "prettier" },
        cpp = { "clangformat" }, -- to change style: ~/.local/share/nvim/mason/bin/clang-format --style GNU --dump-config > .clang_format
        c = { "clangformat" },
    },
    -- format_on_save = {
    --     lsp_fallback = false,
    --     async = false,
    --     -- timeout_ms = 500,
    -- },
    format_after_save = {
        -- lsp_fallback = false,
    },
    notify_on_error = true,
})

-- linting
-- need to install linters via Mason or package manager
require("lint").linters_by_ft = {
    javascript = { "eslint_d" },
    typescript = { "eslint_d" },
    python = { "ruff" },
    -- python = { 'pylint' },
    -- python = { 'flake8' },
    -- python = { 'mypy' },
}

local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

-- vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
vim.api.nvim_create_autocmd({ "BufWritePost" }, {
    group = lint_augroup,
    callback = function()
        require("lint").try_lint()
    end,
})
