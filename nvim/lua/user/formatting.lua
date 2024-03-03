-- https://www.josean.com/posts/neovim-linting-and-formatting
-- also, there is none-ls which replaces null-ls

-- formatting
require("conform").setup({
  formatters_by_ft = {
    -- lua = { "stylua" },
    -- python = { "isort", "black" },
    python = { "isort", "ruff_format" },
    -- python = { "ruff_format" },
    javascript = { "prettier" },
    typescript = { "prettier" },
    css = { "prettier" },
    html = { "prettier" },
    json = { "prettier" },
    markdown = { "prettier" },
  },
  format_on_save = {
    lsp_fallback = true,
    async = false,
    -- timeout_ms = 500,
  },
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
