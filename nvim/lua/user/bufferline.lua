require('bufferline').setup{
  options = {
    close_command = 'bp|bd #',
    right_mouse_command = 'bp|bd #',
    diagnostics = 'nvim_lsp',
    offsets = {
      {
        filetype = 'NvimTree',
        text='File Explorer',
        text_align = 'left'
      }
    },
  }
}
