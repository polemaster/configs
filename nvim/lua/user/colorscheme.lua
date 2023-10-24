require('catppuccin').setup({
  integrations = {
    barbar = true,
    notify = true,
    mason = true,
  },
  styles = {
    conditionals = {},
  }
})


vim.cmd('colorscheme catppuccin')

-- require('onedark').setup {
--   style = 'deep'
-- }
-- require('onedark').load()
