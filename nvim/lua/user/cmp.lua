-- maybe usefull: `:help cmp-faq`
local cmp = require("cmp")
local luasnip = require("luasnip")
require("luasnip.loaders.from_vscode").lazy_load()
luasnip.config.setup({})

-- No idea why this function is needed in tab key but here is its description:
-- Determine whether there are words (non-space characters) before the cursor position in the current buffer of Neovim
local has_words_before = function()
    unpack = unpack or table.unpack
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

cmp.setup({
    -- Disable automatic selection of the item
    -- preselect = cmp.PreselectMode.None,

    -- Disable completion in comments
    enabled = function()
        local context = require("cmp.config.context")

        -- Disable completion in telescope prompt
        if vim.bo.buftype == "prompt" then
            return false
        end

        if vim.api.nvim_get_mode().mode == "c" then
            return true
        else
            -- keep command mode completion enabled when cursor is in a comment
            return not context.in_treesitter_capture("comment") and not context.in_syntax_group("Comment")
        end
    end,

    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end,
    },

    window = {
        documentation = cmp.config.window.bordered(),
    },

    mapping = cmp.mapping.preset.insert({
        ["<C-j>"] = cmp.mapping.select_next_item(),
        ["<C-k>"] = cmp.mapping.select_prev_item(),
        ["<C-u>"] = cmp.mapping.scroll_docs(-4),
        ["<C-d>"] = cmp.mapping.scroll_docs(4),
        -- ['<C-e>'] = cmp.mapping.abort()    -- Not neccessary?, also possible: cmp.mapping.close()
        ["<C-Space>"] = cmp.mapping.complete({}),
        ["<CR>"] = cmp.mapping.confirm({
            select = false, -- after typing enter I go to the next line instead of confirming selection
        }),
        ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                -- If there is only one item select it automatically after pressing tab
                if #cmp.get_entries() == 1 then
                    cmp.confirm({ select = true })
                else
                    cmp.select_next_item()
                end
            elseif luasnip.expand_or_locally_jumpable() then
                luasnip.expand_or_jump()
            elseif has_words_before() then
                cmp.complete() -- or fallback() ???
                if #cmp.get_entries() == 1 then
                    cmp.confirm({ select = true })
                end
            else
                fallback()
            end
        end, { "i", "s" }),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            elseif luasnip.locally_jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end, { "i", "s" }),
    }),

    formatting = {
        -- from left to right what appears in the completion menu
        fields = { "kind", "abbr", "menu" },

        format = function(entry, item)
            local color_item = require("nvim-highlight-colors").format(entry, { kind = item.kind })
            item = require("lspkind").cmp_format({
                mode = "symbol", -- only symbols are shown (without text)
                menu = {
                    nvim_lsp = "[LSP]",
                    luasnip = "[Snippet]",
                    buffer = "[Buffer]",
                    path = "[Path]",
                },
            })(entry, item)
            if color_item.abbr_hl_group then
                item.kind_hl_group = color_item.abbr_hl_group
                item.kind = color_item.abbr
            end
            return item
        end,
    },

    sources = {
        { name = "nvim_lsp" },
        { name = "luasnip" },
        { name = "buffer" },
        { name = "path" },
    },
})

-- Set up completion from command mode
cmp.setup.cmdline(":", {
    mapping = cmp.mapping.preset.cmdline({
        -- Disable nvim-cmp Ctrl+n and Ctrl+p keybindings
        ["<C-n>"] = function() end,
        ["<C-p>"] = function() end,

        -- Set Ctrl+j and Ctrl+k to move through the items of completion list
        ["<C-j>"] = cmp.mapping({
            c = function()
                if cmp.visible() then
                    cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
                end
            end,
        }),
        ["<C-k>"] = cmp.mapping({
            c = function()
                if cmp.visible() then
                    cmp.select_prev_item({ behavior = cmp.SelectBehavior.Select })
                end
            end,
        }),
    }),
    sources = cmp.config.sources({
        { name = "path" },
    }, {
        {
            name = "cmdline",
            option = {
                ignore_cmds = { "Man", "!" },
            },
        },
    }),
})
