require("neorg").setup({
    load = {
        ["core.defaults"] = {}, -- Loads default behavior
        ["core.concealer"] = {
            config = {
                icon_preset = "diamond",
            },
        }, -- Adds pretty icons to your documents
        ["core.dirman"] = { -- Manages Neorg workspaces
            config = {
                workspaces = {
                    notes = "~/notes",
                },
            },
        },
    },
})
