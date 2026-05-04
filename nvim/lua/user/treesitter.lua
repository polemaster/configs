-- treesitter.lua
local keymaps = require("user.keymaps").treesitter

-- 1. Setup Commentstring (Still needed as a separate plugin)
require("ts_context_commentstring").setup({
  enable_autocmd = false,
})

require("nvim-treesitter").install({
  "c",
  "cpp",
  "lua",
  "python",
  "vimdoc",
  "vim",
  "html",
  "css",
  "scss",
  "javascript",
  "typescript",
  "tsx",
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
  "php",
  "regex",
  "sql",
  "xml",
})
-- 2. Setup nvim-treesitter (Main branch style)
-- require("nvim-treesitter.configs").setup({
--   -- These fields are still valid on the main branch for managing parsers
--   auto_install = true,

--   -- HIGHLIGHTING: In 0.12, this is moving toward native.
--   -- Some users now use: vim.treesitter.start()
--   -- But for now, this block usually still works on the main branch:
--   highlight = {
--     enable = true,
--     additional_vim_regex_highlighting = false,
--   },
-- })

-- 3. NATIVE INDENT: Neovim 0.12 handles this better natively
vim.wo.foldmethod = "expr"
vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
-- (Note: 'indent' is now largely automatic with Treesitter enabled)

-- 4. TEXTOBJECTS & OTHERS:
-- Plugins like nvim-treesitter-textobjects still need their own setup
-- usually called outside the main configs.setup block now:
-- require("nvim-treesitter-textobjects.select").setup({
--   enable = true,
--   lookahead = true,
--   keymaps = keymaps.selection,
-- })

-- require("nvim-treesitter-textobjects.move").setup({
--   enable = true,
--   set_jumps = true,
--   goto_next_start = keymaps.motion.next_start,
--   goto_next_end = keymaps.motion.next_end,
--   goto_previous_start = keymaps.motion.previous_start,
--   goto_previous_end = keymaps.motion.previous_end,
-- })

-- 5. MATCHUP:
-- This is what caused your initial crash. Ensure vim-matchup is updated.
-- If it still crashes, keep it disabled until they patch for 0.12.
vim.g.matchup_enabled = 1
