local conf = {
    path = nil
}

function conf:load(script, pred)
    local pred = (pred ~= false)
    if not pred then
        return
    end
    ext = string.sub(script, -3)
    if ext == "vim" then
        vim.cmd("source " .. self.path .. "/init.d/" .. script)
    elseif ext == "lua" then
        mod = string.sub(script, 0, -5)
        require(mod)
    end
end

local M = {}

function M.setup(path)
    package.path = path .. "/init.d/?.lua"
    conf.path = path

    conf:load('globals.vim')
    conf:load('plugins.vim')
    conf:load('common.vim')
    conf:load('colorscheme.vim')

    conf:load('lsp.lua', vim.g.vimrc_enable_lsp)
    conf:load('lsp_signature.lua', vim.g.vimrc_enable_lsp and vim.g.vimrc_enable_lsp_signature)
    conf:load('ts.lua', vim.g.vimrc_enable_treesitter)
    conf:load('gitsigns.lua')

    conf:load('nerdtree.vim', vim.g.vimrc_enable_nerdtree)
    conf:load('nvim-tree.lua', vim.g.vimrc_enable_nvimtree)

    conf:load('easyalign.vim')
    conf:load('python.vim')

    conf:load('airline.vim', vim.g.vimrc_enable_airline)
    conf:load('barbar.vim', vim.g.vimrc_enable_barbar)

    if vim.g.vimrc_enable_feline then
        vim.o.showmode = false
        conf:load('feline.lua')
    end

    conf:load('telescope.lua', vim.g.vimrc_enable_telescope)
    conf:load('fzf.vim', vim.g.vimrc_enable_fzf)
    conf:load('ack.vim', vim.g.vimrc_enable_ack)

    conf:load('nerdcommenter.vim')
    conf:load('vimtex.vim')
    conf:load('clang-format.vim')

    conf:load('nvim-cmp.lua', vim.g.vimrc_enable_nvim_cmp)

    conf:load('colorizer.lua')
    conf:load("custom.vim")

    conf:load('neorg.lua', vim.g.vimrc_enable_neorg)
    conf:load('orgmode.lua', vim.g.vimrc_enable_orgmode)
end

return M
