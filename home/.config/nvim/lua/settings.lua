-- Set <space> as the leader key.
-- Must happen before plugins are required (otherwise the wrong leader will be used).
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Add binaries installed by mason.nvim to path.
vim.env.PATH = vim.env.PATH .. ':' .. vim.fn.stdpath 'data' .. '/mason/bin'

-- Use an indentation of 2 spaces.
vim.o.sw = 2
vim.o.ts = 2
vim.o.et = true

-- Show whitespace.
vim.opt.list = true
vim.opt.listchars = { space = '⋅', trail = '⋅', tab = '  ' }

-- Show line numbers.
vim.wo.number = true

-- Enable mouse mode.
vim.o.mouse = 'a'

-- Disable horizontal scrolling.
vim.o.mousescroll = 'ver:3,hor:0'

-- Wrap long lines at words.
vim.o.linebreak = true

-- Sync clipboard between the OS and Neovim.
vim.o.clipboard = 'unnamedplus'

-- Save undo history.
vim.o.undofile = true

-- Case insensitive searching UNLESS /C or the search has capitals.
vim.o.ignorecase = true
vim.o.smartcase = true