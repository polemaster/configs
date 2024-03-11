-- nvim-notify plugin
vim.notify = require("notify")

require("notify").setup({
    render = "minimal",
    stages = "fade_in_slide_out", -- default value
})

-- fidget.nvim plugin
require("fidget").setup({})
