local keymaps = require("user.keymaps")

require("Comment").setup({
  opleader = keymaps.comments.opleader,
  toggler = keymaps.comments.toggler,
  mappings = keymaps.comments.mappings,
  -- for tsx/jsx, other languages work out-of-the-box:
  pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
  -- ignore empty lines
  ignore = "^$",
})
