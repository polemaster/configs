require("auto-session").setup({
  suppresses_dirs = { "~/", "~/Projects", "~/Downloads", "/" },

  cwd_change_handling = {
    restore_upcoming_session = true, -- already the default, no need to specify like this, only here as an example
    pre_cwd_changed_hook = nil, -- already the default, no need to specify like this, only here as an example
    post_cwd_changed_hook = function() -- example refreshing the lualine status line _after_ the cwd changes
      require("lualine").refresh() -- refresh lualine so the new session name is displayed in the status bar
    end,
  },

  bypass_save_filetypes = { "dashboard" }, -- or whatever dashboard you use

  -- this saves session correctly when I close files before closing NvimTree by mistake
  pre_save_cmds = { "NvimTreeClose" },
})
