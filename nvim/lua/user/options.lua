--vim.wo.number = true
-- vim.g.loaded_netrw = 1
-- vim.g.loaded_netrwPlugin = 1


vim.o.number = true
vim.o.breakindent = true                          -- Lines longer than one are indented indetitically
vim.o.clipboard = 'unnamedplus'
vim.o.hlsearch = false
vim.o.mouse = 'a'
vim.o.undofile = true                             -- Save undo history
vim.o.scrolloff = 10

vim.o.ignorecase = true
vim.o.smartcase = true                            -- Case-insensitive searching UNLESS \C or capital in search

vim.o.signcolumn = 'yes'                          -- Keep signcolumn on by default (the one on the left, before line numbers)

vim.o.updatetime = 300                            -- faster something?, Decrease update time
vim.o.timeoutlen = 300                            -- the time that Vim waits for after each keystroke of the mapping before aborting it
                                                  -- see also: timeout & https://vi.stackexchange.com/questions/24925/usage-of-timeoutlen-and-ttimeoutlen
vim.o.completeopt = 'menuone,noselect'            -- Set completeopt to have a better completion experience
vim.o.termguicolors = true                        -- NOTE: You should make sure your terminal supports this

vim.o.pumheight = 10                              -- limits the height of pop-up menu to 10

-- Tab options (they don't work due to vim-sleuth)
vim.o.expandtab = true
vim.o.tabstop = 2
vim.o.shiftwidth = 2

vim.opt.iskeyword:append('-')                     -- treats sth-sth as one word (useful for w motion)


-- Folding
vim.o.foldmethod = "expr"
vim.o.foldexpr = "nvim_treesitter#foldexpr()"
-- vim.o.foldenable = false
vim.o.foldlevel = 99

-- Notifications
vim.notify = require("notify")

