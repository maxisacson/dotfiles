local map = vim.keymap.set
local opts = { silent = true }

-- Move to previous/next
map('n', '<Leader>w', ':BufferPrevious<CR>', opts)
map('n', '<Leader>e', ':BufferNext<CR>', opts)
-- Re-order to previous/next
map('n', '<Leader>s', ':BufferMovePrevious<CR>', opts)
map('n', '<Leader>d', ':BufferMoveNext<CR>', opts)
-- Goto buffer in position...
map('n', '<Leader>1', ':BufferGoto 1<CR>', opts)
map('n', '<Leader>2', ':BufferGoto 2<CR>', opts)
map('n', '<Leader>3', ':BufferGoto 3<CR>', opts)
map('n', '<Leader>4', ':BufferGoto 4<CR>', opts)
map('n', '<Leader>5', ':BufferGoto 5<CR>', opts)
map('n', '<Leader>6', ':BufferGoto 6<CR>', opts)
map('n', '<Leader>7', ':BufferGoto 7<CR>', opts)
map('n', '<Leader>8', ':BufferGoto 8<CR>', opts)
map('n', '<Leader>9', ':BufferLast<CR>', opts)
-- Close buffer
map('n', '<Leader>qq', ':BufferClose<CR>', opts)
-- Wipeout buffer
--                          :BufferWipeout<CR>
-- Close commands
--                          :BufferCloseAllButCurrent<CR>
--                          :BufferCloseBuffersLeft<CR>
--                          :BufferCloseBuffersRight<CR>
-- Magic buffer-picking mode
map('n', '<C-s>', ':BufferPick<CR>', opts)
-- Sort automatically by...
map('n', '<Space>bd', ':BufferOrderByDirectory<CR>', opts)
map('n', '<Space>bl', ':BufferOrderByLanguage<CR>', opts)

-- Other:
-- :BarbarEnable - enables barbar (enabled by default)
-- :BarbarDisable - very bad command, should never be used

vim.g.bufferline = {
    animation = false, -- disable/enable animation
    closable = false, -- disable/enable close button
    clickable = false, -- disable/enable clickable tabs
    icons = 'both',
    icon_custom_colors = false,
    maximum_padding = 0
    -- icon_separator_active = ''
    -- icon_separator_inactive = ''
}

local function fg(group)
    local hl = vim.api.nvim_get_hl_by_name(group, 1)
    return string.format('#%06x', hl.foreground)
end

local bg0 = fg("GruvboxBg0")
local bg1 = fg("GruvboxBg1")
local bg2 = fg("GruvboxBg2")
local bg4 = fg("GruvboxBg4")
local fg1 = fg("GruvboxFg1")
local fg4 = fg("GruvboxFg4")
local red = fg("GruvboxRed")
local orange = fg("GruvboxOrange")
local blue = fg("GruvboxBlue")
local yellow  = fg("GruvboxYellow")
local purple = fg("GruvboxPurple")
local aqua = fg("GruvboxAqua")
local green = fg("GruvboxGreen")
local gray = fg("GruvboxGray")

-- Meaning of terms:
--
-- format: "Buffer" + status + part
--
-- status:
--     *Current: current buffer
--     *Visible: visible but not current buffer
--    *Inactive: invisible but not current buffer
--
-- part:
--        *Icon: filetype icon
--       *Index: buffer index
--         *Mod: when modified
--        *Sign: the separator between buffers
--      *Target: letter in buffer-picking mode
--
-- BufferTabpages: tabpage indicator
-- BufferTabpageFill: filler after the buffer section
-- BufferOffset: offset section, created with set_offset()

local function hi(...)
    return vim.api.nvim_set_hl(0, ...)
end

hi('BufferCurrent', { fg=fg1, bg=bg2, bold=1 })
hi('BufferCurrentIndex', { fg=fg4, bg=bg2 })
hi('BufferCurrentMod', { fg=yellow, bg=bg2, bold=1 })
hi('BufferCurrentSign', { fg=bg2, bg=bg2 })
hi('BufferCurrentTarget', { fg=red, bg=bg2, bold=1 })

hi('BufferVisible', { fg=blue, bg=bg1 })
hi('BufferVisibleIndex', { fg=blue, bg=bg1 })
hi('BufferVisibleMod', { fg=yellow, bg=bg1 })
hi('BufferVisibleSign', { fg=bg2, bg=bg1 })
hi('BufferVisibleTarget', { fg=red, bg=bg1, bold=1 })

hi('BufferInactive', { fg=bg4, bg=bg1 })
hi('BufferInactiveIndex', { fg=bg4, bg=bg1 })
hi('BufferInactiveMod', { fg=yellow, bg=bg1 })
hi('BufferInactiveSign', { fg=bg2, bg=bg1 })
hi('BufferInactiveTarget', { fg=red, bg=bg1, bold=1 })

hi('BufferTabpages', { fg=orange, bg=bg1, bold=1 })
hi('BufferTabpageFill', { fg=bg4, bg=bg1 })

hi('BufferCurrentIcon', { link='BufferCurrent' })
hi('BufferVisibleIcon', { link='BufferVisible' })
hi('BufferInactiveIcon', { link='BufferInactive' })
hi('BufferOffset', { link='BufferTabpageFill' })
