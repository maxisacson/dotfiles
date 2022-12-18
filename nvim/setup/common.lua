local opt = vim.opt
local g = vim.g

-- Set indenting stuff
opt.tabstop = 4 -- number of spaces in a <Tab>
opt.shiftwidth = 4 -- number of spaces to use for autoindent. Should be == tabstop
opt.softtabstop = 4 -- number of spaces for <Tab> when editing
opt.expandtab = true -- use spaces as <Tab>
opt.smarttab = true -- insert shiftwidth worth of whitespace at beginning of line
opt.backspace = 'indent,eol,start' -- make <BS> well behaved
opt.autoindent = true -- make sure autoindent is turned on
opt.cinoptions = 'l1,g0.75s,h0.25s,N-s'
opt.smartindent = true

-- Format options
opt.textwidth = 80
opt.formatoptions:remove { 't' }

-- status line
-- 0: never
-- 1: only if there are at least two windows
-- 2: always
-- 3: always and ONLY the last window
opt.laststatus = 3

-- block cursor
opt.guicursor = ""

-- Set incremental search
opt.incsearch = true

-- Always keep 2 line above and below cursor,
-- and 5 columns to the right and left
opt.scrolloff = 2
opt.sidescrolloff = 5

-- Line numbering
opt.number = true
opt.relativenumber = true

-- Show command
opt.showcmd = true

-- Set default spell language
opt.spelllang = 'en_gb'

-- Set window title
opt.title = true

-- Always use ft=tex as default for .tex-files
g.tex_flavor = 'latex'

-- Map , to <Leader>
g.mapleader = ','

-- always split the screen to the right or below
opt.splitright = true
opt.splitbelow = true

-- Always show sign column
opt.signcolumn = 'yes'

-- Highlight the current line
opt.cursorline = true

-- Highlight column
opt.colorcolumn = '+1'
vim.cmd([[highlight ColorColumn ctermbg=Black]])

-- Enable mouse
opt.mouse = 'a'

-- show list chars
opt.list = true
opt.listchars = { tab = '└─', trail = '∙', nbsp = '␣' }

-- swapfile, undo, and backup
opt.swapfile = false
opt.backup = false
opt.undofile = true


local function map(...) vim.keymap.set(...) end

-- Window movement bindings
map('n', '<C-Left>', '<C-w>h')
map('n', '<C-Right>', '<C-w>l')
map('n', '<C-Up>', '<C-w>k')
map('n', '<C-Down>', '<C-w>j')
map('n', '<C-h>', '<C-w>h')
map('n', '<C-l>', '<C-w>l')
map('n', '<C-k>', '<C-w>k')
map('n', '<C-j>', '<C-w>j')
-- convenience mapping for CTRL_W
map('n', '`', '<C-w>')
map('n', '§', '<C-w>')


-- Window resize bindings
map('n', '<Leader>+', '<C-w>+')
map('n', '<Leader>-', '<C-w>-')
map('n', '<Leader>>', '<C-w>>')
map('n', '<Leader><', '<C-w><')

-- Buffer management
opt.hidden = true -- allow buffers to be open in the background
map('n', '<Leader><Leader>', '<C-^>')
-- " if !g:vimrc.enable_barbar
-- "     nnoremap <Leader>w :bprev<CR>
-- "     nnoremap <Leader>e :bnext<CR>
-- "     nnoremap <silent> <leader>qq :b# <BAR> bd #<CR>
-- " endif

-- " Tab management
-- " nnoremap <S-q> :tabp<CR>
-- " nnoremap <S-w> :tabnew<CR>
-- " nnoremap <S-e> :tabn<CR>
-- " nnoremap <silent> <Leader><S-q> :execute 'silent! tabmove ' . (tabpagenr()-2)<CR>
-- " nnoremap <silent> <Leader><S-e> :execute 'silent! tabmove ' . (tabpagenr()+1)<CR>

-- mappings for quickfix list apart from tab
map('n', '<leader>qn', ':cnext<CR>')
map('n', '<leader>qp', ':cprev<CR>')
map('n', '<leader>qf', ':cfirst<CR>')
map('n', '<leader>ql', ':clast<CR>')
map('n', '<leader>qc', ':cclose<CR>')
map('n', '<leader>qo', ':copen<CR>')

-- mappings for location list apart from tab
map('n', '<leader>ln', ':lnext<CR>')
map('n', '<leader>lp', ':lprev<CR>')
map('n', '<leader>lf', ':lfirst<CR>')
map('n', '<leader>ll', ':llast<CR>')
map('n', '<leader>lc', ':lclose<CR>')
map('n', '<leader>lo', ':lopen<CR>')

-- command line editing
map('c', '<C-a>', '<Home>') -- start of line
map('c', '<C-e>', '<End>') -- end of line
map('c', '<C-f>', '<Right>') -- forward one character
map('c', '<C-b>', '<Left>') -- back one character
map('c', '<C-d>', '<Del>') -- delete character under cursor
map('c', '<A-b>', '<S-Left>') -- back one word
map('c', '<A-f>', '<S-Right>') -- forward one word

-- move selected line/block down/up/right/left
map('v', 'J', ":m '>+1<CR>gv=gv")
map('v', 'K', ":m '<-2<CR>gv=gv")
map('v', '>', ">gv")
map('v', '<', "<gv")
