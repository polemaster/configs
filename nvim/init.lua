--[[

example (good) files/directories structure:
https://github.com/josean-dev/dev-environment-files/tree/main/.config/nvim/lua/josean/plugins


  If you don't know anything about Lua, I recommend taking some time to read through
  a guide. One possible example:
  - https://learnxinyminutes.com/docs/lua/

  And then you can explore or search through `:help lua-guide`
  - https://neovim.io/doc/user/lua-guide.html


Plugins will be lazy-loaded when one of the following is true:

    - The plugin only exists as a dependency in your spec
    - It has an event, cmd, ft or keys key
    - config.defaults.lazy == true

--]]

-- Set <space> as the leader key
-- NOTE: Must happen before plugins are required (otherwise wrong leader will be used)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Lazy setup
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Lazy load all plugins by default
-- require("lazy").setup("user.plugins", { defaults = { lazy = true } })
require("lazy").setup("user.plugins")

require("user.options")
require("user.keymaps")
require("user.cmp")
require("user.telescope")
require("user.treesitter")
require("user.lsp")
require("user.autopairs")
require("user.comments")
require("user.nvimtree")
require("user.toggleterm")
require("user.bufferline")
require("user.colorscheme")
require("user.notifications")
require("user.sessions")
require("user.debugging")
require("user.formatting")
require("user.lualine")
require("user.trouble")
require("user.dashboard")
require("user.neorg")
require("user.oil")
require("user.git")
require("user.zen")
require("user.autotag")
require("user.autosave")

-- document existing key chains, check https://github.com/folke/which-key.nvim

require("which-key").add({
  { "<leader>c", group = "[C]ode" },
  { "<leader>c_", hidden = true },
  { "<leader>d", group = "[D]ocument" },
  { "<leader>d_", hidden = true },
  { "<leader>g", group = "[G]it" },
  { "<leader>g_", hidden = true },
  { "<leader>r", group = "[R]ename" },
  { "<leader>r_", hidden = true },
  { "<leader>s", group = "[S]earch" },
  { "<leader>s_", hidden = true },
  { "<leader>w", group = "[W]orkspace" },
  { "<leader>w_", hidden = true },
})
