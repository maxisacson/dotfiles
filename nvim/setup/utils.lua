-- Utility functions

local U = {}
function U.python_interpreter()
    if vim.g.vimrc.override_python3_host_prog then
        return vim.g.vimrc.python3_host_prog
    end

    if vim.fn.empty(vim.fn.glob("/usr/bin/python3")) then
        return vim.fn.system("which python3")
    end

    return "/usr/bin/python3"
end

local function setup()
    vim.g.utils = U
end

setup()
