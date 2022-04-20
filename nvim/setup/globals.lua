local M = {}

function M.build_config(opt)
    local default_opt = {
        disable_vim_cmake = vim.fn.executable("cmake") == 0,
        disable_telescope = false,
        disable_fzf = true,
        disable_ack = true,
        disable_lsp = false,
        disable_treesitter = false,
        disable_nvim_cmp = false,
        disable_neorg = true,
        disable_orgmode = true,
        disable_lsp_signature = false,

        -- " Fix lsp floating diagnostic for 'ellisonleao/gruvbox.nvim'
        fix_normalfloat_hilink_to_pmenu = true,

        colorscheme = "gruvbox",
        override_python3_host_prog = false,
        python3_host_prog = "python",
        pylsp_cmd = "pylsp",
        lualsp_cmd = "lua-language-server",

        path = vim.env['HOME'] .. '/.config/nvim'
    }

    local user_opt = default_opt
    for k,v in pairs(opt) do
        if user_opt[k] ~= nil then
            user_opt[k] = v
        else
            error('unknown opt: ' .. k)
        end
    end

    if not user_opt.disable_telescope then
        if not user_opt.disable_fzf then
            print("Incompatible: disable_telescope = false and disable_fzf = false. Setting disable_fzf = true")
            user_opt.disable_fzf = true
        end
        if not user_opt.disable_ack then
            print("Incompatible: disable_telescope = false and disable_ack = false. Setting disable_ack = true")
            user_opt.disable_ack = true
        end
    end

    return user_opt
end

function M.setup(opt)
    vim.g.vimrc = M.build_config(opt)
end

return M
