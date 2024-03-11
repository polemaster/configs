-- It is possible to add rules for specific filetypes. Check https://github.com/windwp/nvim-autopairs for more information.

require("nvim-autopairs").setup({
    check_ts = true,
    ts_config = {
        lua = { "string", "source" },
        javascript = { "string", "template_string" },
        java = false,
    },
    fast_wrap = {
        map = "<M-e>", -- alt+e in insert mode enables wrapping brackets
        chars = { "{", "[", "(", '"', "'" },
        pattern = string.gsub([[ [%'%"%)%>%]%)%}%,] ]], "%s+", ""),
        offset = 0, -- Offset from pattern match
        end_key = "$",
        keys = "qwertyuiopzxcvbnmasdfghjkl",
        check_comma = true,
        highlight = "PmenuSel",
        highlight_grey = "LineNr",
    },
})

local cmp_autopairs = require("nvim-autopairs.completion.cmp")
local cmp = require("cmp")
cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done({ filetypes = { tex = false } }))

-- custom rules
local npairs = require("nvim-autopairs")
local Rule = require("nvim-autopairs.rule")
local cond = require("nvim-autopairs.conds")

local brackets = { { "(", ")" }, { "[", "]" }, { "{", "}" } }

-- Rule 1 (| is a cursor)

-- Before 	Insert 	  After
-- (|) 	    space 	  ( | )
npairs.add_rules({
    -- Rule for a pair with left-side ' ' and right side ' '
    Rule(" ", " ")
        -- Pair will only occur if the conditional function returns true
        :with_pair(function(opts)
            -- We are checking if we are inserting a space in (), [], or {}
            local pair = opts.line:sub(opts.col - 1, opts.col)
            return vim.tbl_contains({
                brackets[1][1] .. brackets[1][2],
                brackets[2][1] .. brackets[2][2],
                brackets[3][1] .. brackets[3][2],
            }, pair)
        end)
        :with_move(cond.none())
        :with_cr(cond.none())
        -- We only want to delete the pair of spaces when the cursor is as such: ( | )
        :with_del(function(opts)
            local col = vim.api.nvim_win_get_cursor(0)[2]
            local context = opts.line:sub(col - 1, col + 2)
            return vim.tbl_contains({
                brackets[1][1] .. "  " .. brackets[1][2],
                brackets[2][1] .. "  " .. brackets[2][2],
                brackets[3][1] .. "  " .. brackets[3][2],
            }, context)
        end),
})

-- For each pair of brackets we will add another rule

-- Rule 2

-- Before 	Insert  	After
-- ( | ) 	  ) 	      (  )|
for _, bracket in pairs(brackets) do
    npairs.add_rules({
        -- Each of these rules is for a pair with left-side '( ' and right-side ' )' for each bracket type
        Rule(bracket[1] .. " ", " " .. bracket[2])
            :with_pair(cond.none())
            :with_move(function(opts)
                return opts.char == bracket[2]
            end)
            :with_del(cond.none())
            :use_key(bracket[2])
            -- Removes the trailing whitespace that can occur without this
            :replace_map_cr(function(_)
                return "<C-c>2xi<CR><C-c>O"
            end),
    })
end

-- Rule 3
-- Move past commas and semicolons (you can't write , or ; if it is already written)
for _, punct in pairs({ ",", ";" }) do
    require("nvim-autopairs").add_rules({
        require("nvim-autopairs.rule")("", punct)
            :with_move(function(opts)
                return opts.char == punct
            end)
            :with_pair(function()
                return false
            end)
            :with_del(function()
                return false
            end)
            :with_cr(function()
                return false
            end)
            :use_key(punct),
    })
end
