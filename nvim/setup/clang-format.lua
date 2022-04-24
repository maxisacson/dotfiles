-- vim-clang-format config

vim.api.nvim_create_autocmd('FileType', {
    pattern = { 'c', 'cpp', 'objc' },
    callback = function()
        vim.api.nvim_buf_set_keymap(0, 'n', '<Leader>f<Space>', ':<C-u>ClangFormat<CR>', { noremap = true })
        vim.api.nvim_buf_set_keymap(0, 'v', '<Leader>f<Space>', ':ClangFormat<CR>', { noremap = true })
    end })

vim.g['clang_format#code_style'] = 'google'
vim.g['clang_format#style_options'] = {
    AlignConsecutiveAssignments = 'false',
    AllowShortFunctionsOnASingleLine = 'Inline',
    BreakConstructorInitializers = 'AfterColon',
    IndentWidth = 4,
    SpaceAfterTemplateKeyword = 'false',
    TabWidth = 4,
    UseTab = 'Never',
    SortIncludes = 'false'
}
