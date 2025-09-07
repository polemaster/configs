-- nvim-notify plugin
vim.notify = require("notify")

require("notify").setup({
    render = "minimal",
    stages = "fade_in_slide_out", -- default value
    top_down = false,
})

-- fidget.nvim plugin
require("fidget").setup({
    notification = {
        window = {
            winblend = 0,
        },
    },
})
