local function setup(mod)
    return require('setup.' .. mod)
end

local M = {}
function M.setup(opt)
    if string.find(package.path, opt.path) == nil then
        package.path = opt.path .. "/?.lua;" .. package.path
    end

    setup('globals').setup(opt)
    setup('utils')
    setup('plugins')
    setup('common')
    setup('colorscheme')
    setup('python')
    setup('terminal')
    setup('custom')
end
return M
