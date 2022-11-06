-- Custom commands, autocommands, mappings, and functions not fitting anywhere else

P = function(v)
    print(vim.inspect(v))
    return v
end

R = function(name)
    require('plenary.reload').reload_module(name)
    return require(name)
end

vim.api.nvim_create_user_command("Reload",
    function(args) return R(args.args) end,
    { force = true, nargs = 1, desc = 'Reload lua module' })

-- Reload vimrc
vim.api.nvim_create_user_command("ReloadVimrc", "so $MYVIMRC | echom 'Reloaded' . $MYVIMRC | redraw", { force = true })

-- Remove all trailing whitespace on write
local trim_white_space = function()
    local cursor_pos = vim.fn.getpos('.')
    vim.cmd([[keeppatterns %s/\s\+$//e]])
    vim.fn.setpos('.', cursor_pos)
end
vim.api.nvim_create_autocmd("BufWrite", {
    group = vim.api.nvim_create_augroup("NoTrailingWhitespace", { clear = true }),
    pattern = "*",
    callback = trim_white_space,
    desc = "Delete trailing white space"
})

-- Auto set cursor line on winenter/winleave. This fixed some issue I can't remember right now
local ag_clear = vim.api.nvim_create_augroup("AutoClearCursorline", { clear = true })
vim.api.nvim_create_autocmd("WinEnter", { group = ag_clear, pattern = "*", command = "setlocal cursorline", })
vim.api.nvim_create_autocmd("WinLeave", { group = ag_clear, pattern = "*", command = "setlocal nocursorline", })

local ag_yank = vim.api.nvim_create_augroup("HighlightYank", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
    group = ag_yank,
    pattern = "*",
    callback = function()
        vim.highlight.on_yank({
            higroup = "Visual",
            timeout = 50,
        })
    end
})

vim.cmd([[
    " Use tab and shift-tab to move in quickfix and location lists
    " function! SmartTab(shifttab)
    "     let isquickfix = !empty(filter(getwininfo(), "v:val.quickfix && !v:val.loclist"))
    "     let isloclist = !empty(filter(getwininfo(), "v:val.loclist"))
    "     if isquickfix
    "         return a:shifttab ? ":cprev\<CR>" : ":cnext\<CR>"
    "     elseif isloclist
    "         return a:shifttab ? ":lprev\<CR>" : ":lnext\<CR>"
    "     else
    "         return a:shifttab ? "\<S-Tab>" : "\<Tab>"
    "     endif
    " endfunction
    " nnoremap <silent> <expr> <Tab> SmartTab(0)
    " nnoremap <silent> <expr> <S-Tab> SmartTab(1)

    " Function to insert include guards in cpp headers
    function! InsertCppIncludeGuard()
        let guard = substitute(toupper(expand("%:t")), "\\.", "_", "g") . "_"

        let cursor_pos = getpos(".")

        execute "normal! ggO#ifndef " . guard
        execute "normal! o#define " . guard
        normal! o
        execute "normal! Go#endif /* " . guard . " */"
        normal! O
        call setpos(".", cursor_pos)
        normal! 3j
    endfunction
    command! CppGuard call InsertCppIncludeGuard()

    " Function to format math expressions inline
    function! PrettifyMath()
        " remove whitespace around *, /, and ^
        s/\s*\(\*\|\/\|\^\|(\|)\)\s*/\1/ge

        " padd +, - and = with whitespace
        s/\(+\|-\|=\)/ \1 /ge

        " remove unnecessary trailing 0's
        s/0\+$/0/ge

        " remove unnecessary whitespace
        s/\s\+/ /ge
        s/^\s\+//ge
        s/\(\d\+\)\s\+\(\d\+\)\+/\1\2/ge

        " make sure negative numbers are written correctly
        s/\(^\|=\s\)-\s/\1-/ge
    endfunction
    " Evaluate current line using bc and make it pretty
    nnoremap <Leader>= :s/=.*$//ge<CR>yypkA=<Esc>j:.!bc -l<CR>kJ:call PrettifyMath()<CR>
    " Evaluate current selection using bc and make it pretty
    vnoremap <Leader>= y'>p:'[,']s/^.*=//ge<CR>:'[,']-1s/\n/+/ge<CR>:s/+$//ge<CR>:.!bc -l<CR>I= <Esc>:'<,'>call PrettifyMath()<CR>j
]])
