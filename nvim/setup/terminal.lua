local map = vim.keymap.set

map('t', '<Esc>', '<C-\\><C-n>', {})
map('t', '<C-h>', '<C-\\><C-n><C-w>h', {})
map('t', '<C-j>', '<C-\\><C-n><C-w>j', {})
map('t', '<C-k>', '<C-\\><C-n><C-w>k', {})
map('t', '<C-l>', '<C-\\><C-n><C-w>l', {})

-- Open split term
map('n', '<Leader>ts', '<Cmd>split | terminal<CR>', {})

local g = vim.api.nvim_create_augroup('TermOpenConfig', { clear=true })
vim.api.nvim_create_autocmd('TermOpen', { group=g, pattern='*', command='set nobuflisted | startinsert' })
vim.api.nvim_create_autocmd('BufEnter', { group=g, pattern='term://*', command='startinsert' })
