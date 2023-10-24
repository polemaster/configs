local opts = { noremap = true, silent = true }
local term_opts = { silent = true }

-- Shorten function name
local keymap = vim.keymap.set

keymap({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Remap for dealing with word wrap
keymap('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
keymap('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Disable annoying keybindings
keymap("", "<S-j>", "<Nop>", opts)

-- Move text up and down
keymap("n", "<A-j>", ":m .+1<CR>==", opts)
keymap("n", "<A-k>", ":m .-2<CR>==", opts)

-- Stay in indent mode after < or >
keymap("v", "<", "<gv^", opts)
keymap("v", ">", ">gv^", opts)

-- After selecting text and pasting sth there, the selected text will not be yanked anymore.
keymap("v", "p", '"_dP', opts)

-- Move text up and down
keymap("v", "<A-j>", ":m '>+1<CR>gv=gv", opts)
keymap("v", "<A-k>", ":m '<-2<CR>gv=gv", opts)

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

-- use bp|bd # or bp|sp|bn|bd to delete a buffer
keymap('n', '<A-c>', ':BufferClose<CR>', opts)
keymap('n', '<A-S-c>', ':BufferRestore<CR>', opts)

-- Telescope
-- See `:help telescope.builtin`
vim.keymap.set('n', '<leader>?', require('telescope.builtin').oldfiles, { desc = '[?] Find recently opened files' })
vim.keymap.set('n', '<leader><space>', require('telescope.builtin').buffers, { desc = '[ ] Find existing buffers' })
vim.keymap.set('n', '<leader>/', function()
  -- You can pass additional configuration to telescope to change theme, layout, etc.
  require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
    winblend = 10,
    previewer = false,
  })
end, { desc = '[/] Fuzzily search in current buffer' })

vim.keymap.set('n', '<leader>gf', require('telescope.builtin').git_files, { desc = 'Search [G]it [F]iles' })
vim.keymap.set('n', '<leader>f', require('telescope.builtin').find_files, { desc = '[S]earch [F]iles' })
vim.keymap.set('n', '<leader>sh', require('telescope.builtin').help_tags, { desc = '[S]earch [H]elp' })
vim.keymap.set('n', '<leader>sw', require('telescope.builtin').grep_string, { desc = '[S]earch current [W]ord' })
vim.keymap.set('n', '<leader>sg', require('telescope.builtin').live_grep, { desc = '[S]earch by [G]rep' })
vim.keymap.set('n', '<leader>sd', require('telescope.builtin').diagnostics, { desc = '[S]earch [D]iagnostics' })
vim.keymap.set('n', '<leader>sr', require('telescope.builtin').resume, { desc = '[S]earch [R]esume' })
