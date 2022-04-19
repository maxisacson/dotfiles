local conf = {
    load = function(mod, pred)
        local pred = (pred ~= false)
        if not pred then
            return
        end
        return require('setup.' .. mod)
    end
}

local M = {}
function M.setup(opt)
    if string.find(package.path, opt.path) == nil then
        package.path = opt.path .. "/?.lua;" .. package.path
    end

    conf.load('globals').setup(opt)
    conf.load('plugins')
    conf.load('common')
    conf.load('colorscheme')

    conf.load('lsp', vim.g.vimrc.enable_lsp)
    conf.load('lsp_signature', vim.g.vimrc.enable_lsp and vim.g.vimrc.enable_lsp_signature)
    conf.load('treesitter', vim.g.vimrc.enable_treesitter)
    conf.load('gitsigns')

    conf.load('nvim-tree')
    conf.load('easyalign')
    conf.load('python')
    conf.load('barbar')
    conf.load('feline')

    conf.load('telescope', vim.g.vimrc.enable_telescope)
    conf.load('fzf', vim.g.vimrc.enable_fzf)
    conf.load('ack', vim.g.vimrc.enable_ack)

    conf.load('nerdcommenter')
    conf.load('vimtex')
    conf.load('clang-format')
    conf.load('nvim-cmp', vim.g.vimrc.enable_nvim_cmp)
    conf.load('colorizer')
    conf.load('custom')

    conf.load('neorg', vim.g.vimrc.enable_neorg)
    conf.load('orgmode', vim.g.vimrc.enable_orgmode)
end
return M
