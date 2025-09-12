require("catppuccin").setup({
  integrations = {
    barbar = true,
    notify = true,
    mason = true,
  },
  styles = {
    conditionals = {},
  },
})

require("tokyonight").setup({
  style = "storm",
  styles = {
    keywords = {},
    sidebars = "transparent",
    floats = "transparent",
  },
})

require("onedark").setup({
  style = "deep",
  diagnostics = {
    background = true, -- set false to disable background for diagnostic messages
  },
  highlights = {
    ["@function"] = { fg = "#9999ff" },
  },
})
require("onedark").load()

-- vim.cmd("colorscheme catppuccin")
vim.cmd("colorscheme tokyonight-night")
-- vim.cmd("colorscheme onedark")
-- vim.cmd("colorscheme gruvbox")
