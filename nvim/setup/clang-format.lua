-- vim-clang-format config

vim.api.nvim_create_autocmd('FileType', {
    pattern = { 'c', 'cpp', 'objc' },
    callback = function()
        vim.keymap.set('n', '<Leader>f<Space>', ':<C-u>ClangFormat<CR>', { buffer = 0 })
        vim.keymap.set('v', '<Leader>f<Space>', ':ClangFormat<CR>', { buffer = 0 })
    end
})

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
