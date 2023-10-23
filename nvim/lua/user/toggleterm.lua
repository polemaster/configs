require('toggleterm').setup({
  open_mapping = [[<c-\>]],
  direction = 'vertical',
  size = 40,
  -- hide_numbers = true, -- hide the number column in toggleterm buffers
})

-- local Terminal = require('toggleterm.terminal').Terminal
-- local python = Terminal:new({ cmd = 'python', hidden = true })
-- function _PYTHON_TOGGLE()
--   python.toggle()
-- end
--
-- vim.keymap.set('n', '<c-p>', ':lua _PYTHON_TOGGLE()<cr>')
