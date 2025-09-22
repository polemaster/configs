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
    scss = { "prettierd" },
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
-- eslint is not included because it's setup by vite usually
require("lint").linters_by_ft = {
  html = { "htmlhint" },
  css = { "stylelint" },
  scss = { "stylelint" },
  python = { "ruff" },
  c = { "cpplint" },
  cpp = { "cpplint" },
  -- python = { 'pylint' },
  -- python = { 'flake8' },
  -- python = { 'mypy' },
}

local stylelint = require("lint").linters.stylelint
stylelint.args = {
  "--formatter",
  "json",
  "--config",
  vim.fn.expand("~/.config/stylelint/.stylelintrc.json"),
  "--stdin-filename",
  function()
    return vim.api.nvim_buf_get_name(0)
  end,
}

local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

-- vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost" }, {
  group = lint_augroup,
  callback = function()
    require("lint").try_lint()
  end,
})
