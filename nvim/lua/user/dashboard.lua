require("dashboard").setup({
  theme = "doom",
  config = {
    header = {
      "",
      "",
      "███╗   ██╗ ███████╗ ██████╗  ██╗   ██╗ ██╗ ███╗   ███╗",
      "████╗  ██║ ██╔════╝██╔═══██╗ ██║   ██║ ██║ ████╗ ████║",
      "██╔██╗ ██║ █████╗  ██║   ██║ ██║   ██║ ██║ ██╔████╔██║",
      "██║╚██╗██║ ██╔══╝  ██║   ██║ ╚██╗ ██╔╝ ██║ ██║╚██╔╝██║",
      "██║ ╚████║ ███████╗╚██████╔╝  ╚████╔╝  ██║ ██║ ╚═╝ ██║",
      "╚═╝  ╚═══╝ ╚══════╝ ╚═════╝    ╚═══╝   ╚═╝ ╚═╝     ╚═╝",
      "",
      "",
    },

        -- stylua: ignore
        center = {
          { action = "Telescope find_files",                                     desc = " Find file",       icon = "", key = "f" },
          { action = "ene | startinsert",                                        desc = " New file",        icon = "", key = "n" },
          { action = "Telescope oldfiles",                                       desc = " Recent files",    icon = "", key = "r" },
          { action = "Telescope live_grep",                                      desc = " Find text",       icon = "", key = "s" },
          { action = "SessionRestore",                                           desc = " Restore Session", icon = "", key = "w" },
          { action = "Lazy",                                                     desc = " Lazy",            icon = "󰒲", key = "l" },
          { action = "qa",                                                       desc = " Quit",            icon = "", key = "q" },
        },

    footer = function()
      local stats = require("lazy").stats()
      local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
      return { "⚡ Neovim loaded " .. stats.loaded .. "/" .. stats.count .. " plugins in " .. ms .. "ms" }
    end,
  },
})
