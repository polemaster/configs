require("auto-save").setup({
  save_fn = function()
    if vim.fn.empty(vim.fn.expand("%")) == 1 then
      -- Prompt for a filename if the buffer is unnamed
      local filename = vim.fn.input("Save as: ", "", "file")
      if filename ~= "" then
        vim.cmd("write " .. filename)
      else
        print("Save canceled")
      end
    else
      vim.cmd("write")
    end
  end,
  condition = function(buf)
    local fn = vim.fn
    local utils = require("auto-save.utils.data")

    -- Check if the buffer is modifiable and has a filetype
    if fn.getbufvar(buf, "&modifiable") == 1 and utils.not_in(fn.getbufvar(buf, "&filetype"), {}) then
      -- Prevent saving unnamed buffers
      if fn.empty(fn.expand("%:p")) == 1 then
        return false -- Do not save unnamed buffers
      end
      return true -- Conditions met, can save
    end
    return false -- Default to not saving
  end,
})
