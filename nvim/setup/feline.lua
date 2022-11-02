local lsp = require('feline.providers.lsp')
local vi_mode_utils = require('feline.providers.vi_mode')

local components = {
    active = {},
    inactive = {},
}

vim.o.showmode = false

table.insert(components.active, {})
table.insert(components.active, {})
table.insert(components.active, {})
table.insert(components.inactive, {})
table.insert(components.inactive, {})

local colors = {
    dark0_hard = '#1d2021',
    dark0 = '#282828',
    dark0_soft = '#32302f',
    dark1 = '#3c3836',
    dark2 = '#504945',
    dark3 = '#665c54',
    dark4 = '#7c6f64',

    light0_hard = '#f9f5d7',
    light0 = '#fbf1c7',
    light0_soft = '#f2e5bc',
    light1 = '#ebdbb2',
    light2 = '#d5c4a1',
    light3 = '#bdae93',
    light4 = '#a89984',

    gray = '#928374',

    bright_red = '#fb4934',
    bright_green = '#b8bb26',
    bright_yellow = '#fabd2f',
    bright_blue = '#83a598',
    bright_purple = '#d3869b',
    bright_aqua = '#8ec07c',
    bright_orange = '#fe8019',

    neutral_red = '#cc241d',
    neutral_green = '#98971a',
    neutral_yellow = '#d79921',
    neutral_blue = '#458588',
    neutral_purple = '#b16286',
    neutral_aqua = '#689d6a',
    neutral_orange = '#d65d0e',

    faded_red = '#9d0006',
    faded_green = '#79740e',
    faded_yellow = '#b57614',
    faded_blue = '#076678',
    faded_purple = '#8f3f71',
    faded_aqua = '#427b58',
    faded_orange = '#af3a03',
}
colors.fg=colors.light1
colors.bg=colors.dark1

local vi_mode_colors = {
    NORMAL = colors.light4,
    OP = colors.light4,
    INSERT = colors.bright_blue,
    VISUAL = colors.bright_orange,
    BLOCK = colors.bright_orange,
    REPLACE = colors.bright_aqua,
    ['V-REPLACE'] = colors.bright_aqua,
    ENTER = colors.bright_purple,
    MORE = colors.bright_purple,
    SELECT = colors.bright_yellow,
    COMMAND = colors.bright_green,
    SHELL = colors.bright_green,
    TERM = colors.bright_green,
    NONE = colors.light4
}

local separators = {
    vertical_bar = '┃',
    vertical_bar_thin = '│',
    left = '',
    right = '',
    block = '█',
    left_filled = '',
    right_filled = '',
    slant_left = '',
    slant_left_thin = '',
    slant_right = '',
    slant_right_thin = '',
    slant_left_2 = '',
    slant_left_2_thin = '',
    slant_right_2 = '',
    slant_right_2_thin = '',
    left_rounded = '',
    left_rounded_thin = '',
    right_rounded = '',
    right_rounded_thin = '',
    circle = '●'
}


table.insert(components.active[1], {
    provider = 'vi_mode',
    hl = function()
        local val = {}
        val.name = vi_mode_utils.get_mode_highlight_name()
        val.bg = vi_mode_utils.get_mode_color()
        val.fg = colors.dark0
        val.style = 'bold'
        return val
    end,
    left_sep = function()
        local val = {hl = {fg = 'NONE', bg = ''}}
        val.str = ' '
        val.hl.bg = vi_mode_utils.get_mode_color()
        return val
    end,
    right_sep = function()
        local val = {hl = {fg = 'NONE', bg = ''}}
        val.str = ' '
        val.hl.bg = vi_mode_utils.get_mode_color()
        return val
    end,
    icon = ''
})

table.insert(components.active[1], {
    provider = 'git_branch',
    hl = { fg = colors.light4, bg = colors.dark2 },
    left_sep = { str = ' ', hl = { fg = colors.light4, bg = colors.dark2 } },
    right_sep = { str = ' ', hl = { fg = colors.light4, bg = colors.dark2 } },
})

table.insert(components.active[1], {
    provider = 'git_diff_added',
    hl = { fg = colors.bright_green, bg = colors.dark2 },
    icon = '+',
    right_sep = { str = ' ', hl = { fg = colors.light4, bg = colors.dark2 } },
})

table.insert(components.active[1], {
    provider = 'git_diff_changed',
    hl = { fg = colors.bright_yellow, bg = colors.dark2 },
    icon = ':',
    right_sep = { str = ' ', hl = { fg = colors.light4, bg = colors.dark2 } },
})

table.insert(components.active[1], {
    provider = 'git_diff_removed',
    hl = { fg = colors.bright_red, bg = colors.dark2 },
    icon = '-',
    right_sep = { str = ' ', hl = { fg = colors.light4, bg = colors.dark2 } },
})

table.insert(components.active[1], {
    provider = 'file_info',
    hl = { fg = colors.light4 },
    left_sep = ' ',
    right_set = ''
})

table.insert(components.active[3], {
    provider = function() return vim.bo.filetype end,
    hl = { fg = colors.light4 },
    left_sep = '',
    right_sep = ' '
})

table.insert(components.active[3], {
    provider = function()
        local enc = (vim.bo.fenc ~= '' and vim.bo.fenc) or vim.o.enc
        local ff = (vim.bo.ff ~= '' and vim.bo.ff) or vim.o.ff
        ff = (ff ~= '' and '['..ff..']') or ''
        return enc..ff
    end,
    hl = { fg = colors.light4, bg = colors.dark2 },
    left_sep = { str = ' ', hl = { bg = colors.dark2 } },
    right_sep = { str = ' ', hl = { bg = colors.dark2 } }
})

table.insert(components.active[3], {
    provider = function()
        local line = vim.fn.line('.')
        local lines = vim.fn.line('$')

        return vim.fn.round(100 * line / lines) .. '%%'
    end,
    hl = { fg = colors.dark0, bg = colors.light4 },
    left_sep = { str = ' ', hl = { bg = colors.light4 } },
    right_sep = { str = ' ', hl = { bg = colors.light4 } }
})

table.insert(components.active[3], {
    provider = function()
        local line = vim.fn.line('.')
        local lines = vim.fn.line('$')
        return string.format('☰ %d/%d ', line, lines)
    end,
    hl = { fg = colors.dark0, bg = colors.light4, style = 'bold' },
    left_sep = '',
    right_sep = ''
})

table.insert(components.active[3], {
    provider = function()
        return string.format(':%d', vim.fn.col('.'))
    end,
    hl = { fg = colors.dark0, bg = colors.light4 },
    left_sep = { str ='', hl = { fg = colors.dark0, bg = colors.light4 } },
    right_sep = { str =' ', hl = { bg = colors.light4 } }
})

table.insert(components.active[3], {
   provider = 'diagnostic_hints',
   enabled = function() return lsp.diagnostics_exist('Hint') end,
   hl = { fg = colors.dark0, bg = colors.light4 },
})

table.insert(components.active[3], {
   provider = 'diagnostic_info',
   enabled = function() return lsp.diagnostics_exist('Info') end,
   hl = { fg = colors.dark0, bg = colors.light4 },
})

table.insert(components.active[3], {
   provider = function(component)
       if lsp.diagnostics_exist('Warn') then
           return lsp.diagnostic_warnings(component)
       end
       return ''
   end,
   hl = { fg = colors.dark0, bg = colors.bright_orange },
   left_sep = { str = '', hl = { fg = colors.dark0, bg = colors.bright_orange } },
   right_sep = { str = ' ', hl = { bg = colors.bright_orange } }
})

table.insert(components.active[3], {
   provider = function(component)
       if lsp.diagnostics_exist('Error') then
           return lsp.diagnostic_errors(component)
       end
       return ''
   end,
   hl = { fg = colors.dark0, bg = colors.bright_red },
   left_sep = { str ='', hl = { fg = colors.dark0, bg = colors.bright_red } },
   right_sep = { str =' ', hl = { bg = colors.bright_red } }
})

table.insert(components.inactive[1], {
    provider = 'file_info',
    hl = { fg = colors.dark4 },
    left_sep = ' ',
    right_set = ''
})

require('feline').setup({
    components=components,
    separators=separators,
    properties=properties,
    vi_mode_colors=vi_mode_colors,
    theme=colors,

    force_inactive = {
        filetypes = {
            'NvimTree',
            'dbui',
            'packer',
            'startify',
            'fugitive',
            'fugitiveblame',
            'nerdtree'
        },
        buftypes = {
            'terminal'
        },
        bufnames = {}
    },
})
