
vim.opt.background = 'dark' -- dark background
vim.opt.termguicolors = true -- 24 bit RGB

-- set colorscheme from global config
vim.cmd('colorscheme ' .. vim.g.vimrc.colorscheme)
