local opt = vim.opt

-- Set indenting stuff
opt.tabstop = 4 -- number of spaces in a <Tab>
opt.shiftwidth = 4 -- number of spaces to use for autoindent. Should be == tabstop
opt.expandtab = true -- use spaces as <Tab>
opt.smarttab = true -- insert shiftwidth worth of whitespace at beginning of line
opt.backspace = 'indent,eol,start' -- make <BS> well behaved
opt.autoindent = true -- make sure autoindent is turned on
opt.cinoptions = 'l1,g0.75s,h0.25s,N-s'

-- Format options
opt.textwidth = 80
opt.formatoptions:remove{'t'}

-- status line
-- 0: never
-- 1: only if there are at least two windows
-- 2: always
-- 3: always and ONLY the last window
opt.laststatus = 3

-- Set incremental search
opt.incsearch = true

-- Always keep 1 line above and below cursor,
-- and 5 columns to the right and left
opt.scrolloff = 1
opt.sidescrolloff = 5

-- Line numbering
opt.number = true

-- Show command
opt.showcmd = true

-- Set default spell language
opt.spelllang = 'en_gb'

-- Set window title
opt.title = true

-- Always use ft=tex as default for .tex-files
vim.g.tex_flavor = 'latex'

-- Map , to <Leader>
vim.g.mapleader = ','

-- always split the screen to the right or below
opt.splitright = true
opt.splitbelow = true

local function keymap(...) vim.api.nvim_set_keymap(...) end

-- Window movement bindings
keymap('n', '<C-Left>',  '<C-w>h', { noremap = true })
keymap('n', '<C-Right>', '<C-w>l', { noremap = true })
keymap('n', '<C-Up>',    '<C-w>k', { noremap = true })
keymap('n', '<C-Down>',  '<C-w>j', { noremap = true })
keymap('n', '<C-h>',     '<C-w>h', { noremap = true })
keymap('n', '<C-l>',     '<C-w>l', { noremap = true })
keymap('n', '<C-k>',     '<C-w>k', { noremap = true })
keymap('n', '<C-j>',     '<C-w>j', { noremap = true })
-- convenience mapping for CTRL_W
keymap('n', '`', '<C-w>', { noremap = true })
keymap('n', '§', '<C-w>', { noremap = true })


-- Window resize bindings
keymap('n', '<Leader>+', '<C-w>+', { noremap = true })
keymap('n', '<Leader>-', '<C-w>-', { noremap = true })
keymap('n', '<Leader>>', '<C-w>>', { noremap = true })
keymap('n', '<Leader><', '<C-w><', { noremap = true })

-- Buffer management
vim.opt.hidden = true -- allow buffers to be open in the background
keymap('n', '<Leader><Leader>', '<C-^>', { noremap = true })
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

-- Highlight column
opt.colorcolumn = '+1'
vim.cmd([[highlight ColorColumn ctermbg=Black]])

-- Always show sign column
opt.signcolumn = 'yes'

-- mappings for quickfix list apart from tab
keymap('n', '<leader>qn', ':cnext<CR>',  { noremap = true })
keymap('n', '<leader>qp', ':cprev<CR>',  { noremap = true })
keymap('n', '<leader>qf', ':cfirst<CR>', { noremap = true })
keymap('n', '<leader>ql', ':clast<CR>',  { noremap = true })
keymap('n', '<leader>qc', ':cclose<CR>', { noremap = true })
keymap('n', '<leader>qo', ':copen<CR>',  { noremap = true })

-- mappings for location list apart from tab
keymap('n', '<leader>ln', ':lnext<CR>',  { noremap = true })
keymap('n', '<leader>lp', ':lprev<CR>',  { noremap = true })
keymap('n', '<leader>lf', ':lfirst<CR>', { noremap = true })
keymap('n', '<leader>ll', ':llast<CR>',  { noremap = true })
keymap('n', '<leader>lc', ':lclose<CR>', { noremap = true })
keymap('n', '<leader>lo', ':lopen<CR>',  { noremap = true })
