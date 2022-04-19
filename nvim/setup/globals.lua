local M = {}

function M.build_config(opt)
    local default_opt = {
        enable_vim_cmake = vim.fn.executable("cmake") == 1,
        enable_telescope = true,
        enable_fzf = false,
        enable_ack = false,
        enable_lsp = true,
        enable_treesitter = true,
        enable_nvim_cmp = true,
        enable_neorg = false,
        enable_orgmode = false,
        enable_lsp_signature = true,

        -- " Fix lsp floating diagnostic for 'ellisonleao/gruvbox.nvim'
        fix_normalfloat_hilink_to_pmenu = true,

        colorscheme = "gruvbox",
        override_python3_host_prog = false,
        python3_host_prog = "python",
        pylsp_cmd = "pylsp",
    }

    local user_opt = default_opt
    for k,v in pairs(user_opt) do
        if opt[k] ~= nil then
            user_opt[k] = opt[k]
        end
    end

    if user_opt.enable_telescope then
        if user_opt.enable_fzf then
            print("Incompatible opts: enable_telescope and enable_fzf. Setting enable_fzf = false")
            user_opt.enable_fzf = false
        end
        if user_opt.enable_ack then
            print("Incompatible opts: enable_telescope and enable_ack. Setting enable_ack = false")
            user_opt.enable_ack = false
        end
    end

    return user_opt
end

function M.setup(opt)
    vim.g.vimrc = M.build_config(opt)
end

return M
