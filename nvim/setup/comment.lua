-- config for Comment.nvim
require('Comment').setup({
    toggler = {
        line = '<Leader>c<Space>',
        block = '<Leader>cb'
    },
    opleader = {
        line = '<Leader>c<Space>',
        block = '<Leader>cb'
    },
    extra = {
        above = '<Leader>cO',
        below = '<Leader>co',
        eol = '<Leader>cA',
    }
})
