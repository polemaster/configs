set nocompatible            " disable compatibility to old-time vi
set hlsearch                " highlight search 
set tabstop=2               " number of columns occupied by a tab 
set softtabstop=2           " see multiple spaces as tabstops so <BS> does the right thing
set expandtab               " converts tabs to white space
set shiftwidth=2            " width for autoindents
set autoindent smartindent  " indent a new line the same amount as the line just typed
set number                  " add line numbers
set wildmode=longest,list   " get bash-like tab completions
syntax on                   " syntax highlighting
set clipboard=unnamedplus   " using system clipboard
filetype plugin indent on   " allow auto-indenting depending on file type
filetype plugin on
set ttyfast                 " Speed up scrolling in Vim
set backupdir=~/.backups
set scrolloff=10
set history=500
