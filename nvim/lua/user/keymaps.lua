-- We will return M so that other files can access these keymaps
-- This is neccessary if we want to have all keymaps in one file
local M = {}


-- Options passed to vim.keymap.set()
local opts = { noremap = true, silent = true }
local term_opts = { silent = true }

-- Shorten function name
local keymap = vim.keymap.set

keymap({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- My custom keymaps
keymap('n', '<c-a>', 'ggVG', opts)
keymap('n', '<leader>z', 'za', opts)
keymap('', '<S-j>', '<Nop>', opts)

-- Remap for dealing with word wrap
keymap('n', 'k', "v:count == 1 ? 'gk' : 'k'", { expr = true, silent = true })
keymap('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Move text up and down
keymap("n", "<A-j>", ":m .+1<CR>==", opts)
keymap("n", "<A-k>", ":m .-2<CR>==", opts)
keymap("v", "<A-j>", ":m '>+1<CR>gv=gv", opts)
keymap("v", "<A-k>", ":m '<-2<CR>gv=gv", opts)

-- Stay in indent mode after < or >
keymap("v", "<", "<gv^", opts)
keymap("v", ">", ">gv^", opts)

-- After selecting text and pasting sth there, the selected text will not be yanked anymore.
keymap("v", "p", '"_dP', opts)

-- Nvimtree
keymap('n', '<leader>e', ':NvimTreeToggle<cr>', opts)

-- Terminal --
-- Useful when terminal is horizontal or vertical (not float) to move between windows
keymap("t", "<C-h>", "<C-\\><C-N><C-w>h", term_opts)
keymap("t", "<C-j>", "<C-\\><C-N><C-w>j", term_opts)
keymap("t", "<C-k>", "<C-\\><C-N><C-w>k", term_opts)
keymap("t", "<C-l>", "<C-\\><C-N><C-w>l", term_opts)

-- Window navigation
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

-- Resize buffers with arrows
keymap("n", "<C-Up>", ":resize -2<CR>", opts)
keymap("n", "<C-Down>", ":resize +2<CR>", opts)
keymap("n", "<C-Left>", ":vertical resize -2<CR>", opts)
keymap("n", "<C-Right>", ":vertical resize +2<CR>", opts)

-- Buffer navigation
-- Bufferline
-- keymap('n', '<A-1>', '<Cmd>BufferLineGoToBuffer 1<CR>', opts)
-- keymap('n', '<A-2>', '<Cmd>BufferLineGoToBuffer 2<CR>', opts)
-- keymap('n', '<A-3>', '<Cmd>BufferLineGoToBuffer 3<CR>', opts)
-- keymap('n', '<A-4>', '<Cmd>BufferLineGoToBuffer 4<CR>', opts)
-- keymap('n', '<A-5>', '<Cmd>BufferLineGoToBuffer 5<CR>', opts)
-- keymap('n', '<A-6>', '<Cmd>BufferLineGoToBuffer 6<CR>', opts)
-- keymap('n', '<A-7>', '<Cmd>BufferLineGoToBuffer 7<CR>', opts)
-- keymap('n', '<A-8>', '<Cmd>BufferLineGoToBuffer 8<CR>', opts)
-- keymap('n', '<A-9>', '<Cmd>BufferLineGoToBuffer 9<CR>', opts)
-- keymap('n', '<A-0>', '<Cmd>BufferLineGoToBuffer -1<CR>', opts)
--
-- keymap('n', '<S-l>', ':BufferLineMoveNext<CR>', opts)
-- keymap('n', '<S-h>', ':BufferLineMovePrev<CR>', opts)
--
-- keymap('n', '<A-l>', ':BufferLineCycleNext<CR>', opts)
-- keymap('n' ,'<A-h>', ':BufferLineCyclePrev<CR>', opts)

-- use bp|bd # or bp|sp|bn|bd to delete a buffer
-- keymap('n', '<A-c>', ':bd<cr>', opts)

-- Barbar
keymap('n', '<A-1>', '<Cmd>BufferGoto 1<CR>', opts)
keymap('n', '<A-2>', '<Cmd>BufferGoto 2<CR>', opts)
keymap('n', '<A-3>', '<Cmd>BufferGoto 3<CR>', opts)
keymap('n', '<A-4>', '<Cmd>BufferGoto 4<CR>', opts)
keymap('n', '<A-5>', '<Cmd>BufferGoto 5<CR>', opts)
keymap('n', '<A-6>', '<Cmd>BufferGoto 6<CR>', opts)
keymap('n', '<A-7>', '<Cmd>BufferGoto 7<CR>', opts)
keymap('n', '<A-8>', '<Cmd>BufferGoto 8<CR>', opts)
keymap('n', '<A-9>', '<Cmd>BufferGoto 9<CR>', opts)
keymap('n', '<A-0>', '<Cmd>BufferLast<CR>', opts)

keymap('n', '<S-l>', ':BufferMoveNext<CR>', opts)
keymap('n', '<S-h>', ':BufferMovePrev<CR>', opts)

keymap('n', '<A-l>', ':BufferNext<CR>', opts)
keymap('n' ,'<A-h>', ':BufferPrev<CR>', opts)

-- use bp|bd # or bp|sp|bn|bd to delete a buffer (without bbye)
keymap('n', '<A-c>', ':BufferClose<CR>', opts)
keymap('n', '<A-S-c>', ':BufferRestore<CR>', opts)




-- Telescope
-- See `:help telescope.builtin`
local builtin = require('telescope.builtin')

keymap('n', '<leader>/', function()
  builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
    winblend = 10, -- ???
    previewer = false,
  })
end, { desc = '[/] Fuzzily search in current buffer' })

keymap('n', '<leader>f', builtin.find_files, { desc = '[S]earch [F]iles' })
keymap('n', '<leader>s', builtin.live_grep, { desc = '[S]earch by [G]rep' })
keymap('n', '<leader>k', builtin.keymaps, { desc = 'Search [K]eymaps' })

keymap('n', '<leader>gf', builtin.git_files, { desc = 'Search [G]it [F]iles' })
keymap('n', '<leader>gc', builtin.git_commits, { desc = 'Search [G]it [C]ommits' })
-- keymap('n', '<leader>d', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' }) -- TO-DO

keymap('n', '<space>t', ':Telescope file_browser path=%:p:h select_buffer=true<CR>', opts)

keymap('n', '<space>n', ':Telescope notify<CR>', { desc = 'Search [N]otifications history' })

-- Useful telescope mappings:
-- <C-x> or <C-s> 	        Go to file selection as a split
-- <C-v>                 	Go to file selection as a vsplit




-- LSP
function M.lsp_on_attach(_, bufnr)
  local nmap = function(keys, func, desc)
      if desc then
        desc = 'LSP: ' .. desc
      end

      vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
  end

  nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
  nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

  -- nmap('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
  nmap('gd', require('telescope.builtin').lsp_definitions, '[G]o to [D]efinition')
  nmap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
  nmap('gI', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')
  nmap('<leader>D', vim.lsp.buf.type_definition, 'Type [D]efinition')
  -- nmap('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
  nmap('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

  -- See `:help K` for why this keymap
  nmap('K', vim.lsp.buf.hover, 'Hover Documentation')

  -- Lesser used LSP functionality
  nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
  nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
  nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
  nmap('<leader>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, '[W]orkspace [L]ist Folders')

  -- Create a command `:Format` local to the LSP buffer
  vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
    vim.lsp.buf.format()
  end, { desc = 'Format current buffer with LSP' })
end


-- Comments
M.comments = {
  opleader = {
    ---Line-comment keymap
    line = '<C-_>',
    ---Block-comment keymap
    block = 'gb',
  },
  toggler = {
    ---Line-comment toggle keymap
    line = '<C-_>',
    ---Block-comment toggle keymap
    block = 'gbc',
  },
  mappings = {
      ---Operator-pending mapping; `gcc` `gbc` `gc[count]{motion}` `gb[count]{motion}`
      basic = true,
      ---Extra mapping; `gco`, `gcO`, `gcA`
      extra = false, -- doesn't work
  },
}

-- Gitsigns
function M.gitsigns(bufnr)
  keymap('n', '<leader>hp', require('gitsigns').preview_hunk, { buffer = bufnr, desc = 'Preview git hunk' })

  -- don't override the built-in and fugitive keymaps
  local gs = package.loaded.gitsigns
  keymap({'n', 'v'}, ']g', function()
    if vim.wo.diff then return ']g' end
    vim.schedule(function() gs.next_hunk() end)
    return '<Ignore>'
  end, {expr=true, buffer = bufnr, desc = "Jump to next hunk"})
  keymap({'n', 'v'}, '[g', function()
    if vim.wo.diff then return '[g' end
    vim.schedule(function() gs.prev_hunk() end)
    return '<Ignore>'
  end, {expr=true, buffer = bufnr, desc = "Jump to previous hunk"})
end


-- Diagnostic keymaps
keymap('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
keymap('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
-- vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
keymap('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })
-- also telescope keymap: <space>d



-- Treesitter
-- more treesitter-textobjects keymaps are in treesitter.lua
local ts_repeat_move = require('nvim-treesitter.textobjects.repeatable_move')

keymap({'n', 'x', 'o'}, ';', ts_repeat_move.repeat_last_move)
keymap({'n', 'x', 'o'}, ',', ts_repeat_move.repeat_last_move_opposite)

keymap({'n', 'x', 'o'}, 'f', ts_repeat_move.builtin_f)
keymap({'n', 'x', 'o'}, 'F', ts_repeat_move.builtin_f)
keymap({'n', 'x', 'o'}, 't', ts_repeat_move.builtin_t)
keymap({'n', 'x', 'o'}, 'T', ts_repeat_move.builtin_T)


M.treesitter = {
  incremental_selection = {
    init_selection = '<c-space>',
    node_incremental = '<c-space>',
    scope_incremental = false,
    node_decremental = '<bs>',
  },
  selection = {
    ["ai"] = { query = "@conditional.outer", desc = "Select outer part of a conditional" },
    ["ii"] = { query = "@conditional.inner", desc = "Select inner part of a conditional" },

    ["al"] = { query = "@loop.outer", desc = "Select outer part of a loop" },
    ["il"] = { query = "@loop.inner", desc = "Select inner part of a loop" },

    ["af"] = { query = "@function.outer", desc = "Select outer part of a method/function definition" },
    ["if"] = { query = "@function.inner", desc = "Select inner part of a method/function definition" },

    -- ["ac"] = { query = "@class.outer", desc = "Select outer part of a class" },
    -- ["ic"] = { query = "@class.inner", desc = "Select inner part of a class" },
  },
  motion = {
    next_start = {
      ["]f"] = { query = "@function.outer", desc = "Next method/function def start" },
      -- ["]c"] = { query = "@class.outer", desc = "Next class start" },
      ["]c"] = { query = "@comment.outer", desc = "Next comment start" },
      ["]i"] = { query = "@conditional.outer", desc = "Next conditional start" },
      ["]l"] = { query = "@loop.outer", desc = "Next loop start" },

      ["]z"] = { query = "@fold", query_group = "folds", desc = "Next fold" },
    },
    next_end = {
      ["]F"] = { query = "@function.outer", desc = "Next method/function def end" },
      -- ["]C"] = { query = "@class.outer", desc = "Next class end" },
      ["]I"] = { query = "@conditional.outer", desc = "Next conditional end" },
      ["]L"] = { query = "@loop.outer", desc = "Next loop end" },
    },
    previous_start = {
      ["[f"] = { query = "@function.outer", desc = "Prev method/function def start" },
      -- ["[c"] = { query = "@class.outer", desc = "Prev class start" },
      ["[c"] = { query = "@comment.outer", desc = "Prev comment start" },
      ["[i"] = { query = "@conditional.outer", desc = "Prev conditional start" },
      ["[l"] = { query = "@loop.outer", desc = "Prev loop start" },
    },
    previous_end = {
      ["[F"] = { query = "@function.outer", desc = "Prev method/function def end" },
      -- ["[C"] = { query = "@class.outer", desc = "Prev class end" },
      ["[I"] = { query = "@conditional.outer", desc = "Prev conditional end" },
      ["[L"] = { query = "@loop.outer", desc = "Prev loop end" },
    },
  },
  peek_definition_code = {
    -- ["<leader>df"] = "@function.outer",
    ["J"] = "@function.outer", -- see definition
    -- ["<leader>dF"] = "@class.outer",
  },
}


-- debugging
local dap, ui = require('dap'), require('dapui')

-- Start debugging session
vim.keymap.set('n', '<leader>ds', function()
  dap.continue()
  ui.toggle({})
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<C-w>=", false, true, true), "n", false) -- Spaces buffers evenly
end)


keymap('n', '<leader>db', dap.toggle_breakpoint, opts)
keymap('n', '<leader>dc', dap.continue, opts)
keymap('n', '<leader>dn', dap.step_over, opts)
keymap('n', '<leader>di', dap.step_into, opts)
keymap('n', '<leader>do', dap.step_out, opts)
keymap('n', '<leader>dC', dap.clear_breakpoints, opts)

-- Close debugger and clear breakpoints
keymap('n', '<leader>de', function()
  dap.clear_breakpoints()
  ui.toggle({})
  dap.terminate()
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<C-w>=", false, true, true), "n", false)
end, opts)

-- Other debugging keybindings (e.g. for scopes: e, <CR>, repl)
-- https://github.com/rcarriga/nvim-dap-ui

keymap("n", "<C-s>", require("auto-session.session-lens").search_session, opts)




-- other useful keymaps:
-- vim-matchup:
-- di% / da% / %

-- nvim-surround:
-- ds{char} / ys{motion}{char} / cs{target}{replacement}


-- returning M is neccessary for other plugins to access this file
return M
