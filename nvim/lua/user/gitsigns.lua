require('gitsigns').setup {
  signs = {
    add = { text = '+' },
    change = { text = '~' },
    delete = { text = '_' },
    topdelete = { text = '‾' },
    changedelete = { text = '~' },
    -- untracked    = { text = '┆' },
  },
  on_attach = require('user.keymaps').gitsigns,
}
