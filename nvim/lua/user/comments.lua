local keymaps = require('user.keymaps')

-- require('Comment').setup({
--   opleader = {
--     ---Line-comment keymap
--     line = '<C-_>',
--     ---Block-comment keymap
--     block = 'gb',
--   },
--   toggler = {
--     ---Line-comment toggle keymap
--     line = '<C-_>',
--     ---Block-comment toggle keymap
--     block = 'gbc',
--   },
--   mappings = {
--       ---Operator-pending mapping; `gcc` `gbc` `gc[count]{motion}` `gb[count]{motion}`
--       basic = true,
--       ---Extra mapping; `gco`, `gcO`, `gcA`
--       extra = false,
--   },
-- })

require('Comment').setup({
  opleader = keymaps.comments.opleader,
  toggler = keymaps.comments.toggler,
  mappings = keymaps.comments.mappings
})

-- require('nvim_comment').setup({
--   line_mapping = "<C-_>",
--   operator_mapping = "<C-_>",
-- })
