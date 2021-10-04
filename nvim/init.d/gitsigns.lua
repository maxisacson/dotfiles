require('gitsigns').setup()

vim.cmd([[
    hi link GitSignsAdd GruvboxGreenSign
    hi link GitSignsChange GruvboxYellowSign
    hi link GitSignsDelete GruvboxRedSign
]])
