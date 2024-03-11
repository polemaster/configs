vim.g.barbar_auto_setup = false
require("barbar").setup({
    animation = false,
    sidebar_filetypes = {
        NvimTree = { text = "File Explorer" },
    },
    focus_on_close = "right",
})

-- Bufferline after closing buffer switches to the last tab so that's
-- the reason I use barbar

-- require('bufferline').setup{
--   options = {
--     close_command = 'bp|bd #',
--     right_mouse_command = 'bp|bd #',
--     offsets = {
--       {
--         filetype = 'NvimTree',
--         text='File Explorer',
--         text_align = 'left'
--       }
--     },
--     separator_style = 'slant',
--     show_buffer_close_icons = false,
--     style_preset = require('bufferline').style_preset.no_italic,
--   },
-- }
