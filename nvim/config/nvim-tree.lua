-- config for nvim-tree

require'nvim-tree'.setup{}

vim.api.nvim_set_keymap('n', '<Leader>nt', ':NvimTreeToggle<CR>', { noremap=true, silent=true })

if vim.g.vimrc.colorscheme == 'gruvbox' then
    vim.cmd([[
    hi link NvimTreeFolderName GruvboxBlueBold
    hi link NvimTreeEmptyFolderName GruvboxBlueBold
    hi link NvimTreeOpenedFolderName GruvboxBlueBold
    hi link NvimTreeGitMerge GruvboxYellow
    hi link NvimTreeGitNew GruvboxYellow
    hi link NvimTreeGitRenamed GruvboxPurple
    hi link NvimTreeGitRootFolder GruvboxPurple
    hi link NvimTreeIndentMarker GruvboxBlue
    hi link NvimTreeFolderIcon GruvboxBlue
    hi link NvimTreeSymlink GruvboxAquaBold

    hi link NvimTreeExecFile GruvboxGreen
    hi link NvimTreeSpecialFile GruvboxOrangeBold
    hi link NvimTreeImageFile GruvboxPurpleBold
    hi link NvimTreeOpenedFile GruvboxOrange
    hi link NvimTreeGitDirty GruvboxRedBold
    hi link NvimTreeGitDeleted GruvboxRedBold
    hi link NvimTreeGitStaged GruvboxRed
    ]])
end
