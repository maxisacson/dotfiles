-- Utility functions

local U = {}
function U.python_interpreter()
    if vim.g.vimrc.override_python3_host_prog then
        return vim.g.vimrc.python3_host_prog
    end

    return "/usr/bin/python"
end

local function setup()
    vim.g.utils = U
end

setup()
