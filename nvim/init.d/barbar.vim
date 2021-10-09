" Move to previous/next
nnoremap <silent>    <Leader>w :BufferPrevious<CR>
nnoremap <silent>    <Leader>e :BufferNext<CR>
" Re-order to previous/next
nnoremap <silent>    <Leader>s :BufferMovePrevious<CR>
nnoremap <silent>    <Leader>d :BufferMoveNext<CR>
" Goto buffer in position...
nnoremap <silent>    <Leader>1 :BufferGoto 1<CR>
nnoremap <silent>    <Leader>2 :BufferGoto 2<CR>
nnoremap <silent>    <Leader>3 :BufferGoto 3<CR>
nnoremap <silent>    <Leader>4 :BufferGoto 4<CR>
nnoremap <silent>    <Leader>5 :BufferGoto 5<CR>
nnoremap <silent>    <Leader>6 :BufferGoto 6<CR>
nnoremap <silent>    <Leader>7 :BufferGoto 7<CR>
nnoremap <silent>    <Leader>8 :BufferGoto 8<CR>
nnoremap <silent>    <Leader>9 :BufferLast<CR>
" Close buffer
nnoremap <silent>    <Leader>qq :BufferClose<CR>
" Wipeout buffer
"                          :BufferWipeout<CR>
" Close commands
"                          :BufferCloseAllButCurrent<CR>
"                          :BufferCloseBuffersLeft<CR>
"                          :BufferCloseBuffersRight<CR>
" Magic buffer-picking mode
nnoremap <silent> <C-s>    :BufferPick<CR>
" Sort automatically by...
nnoremap <silent> <Space>bd :BufferOrderByDirectory<CR>
nnoremap <silent> <Space>bl :BufferOrderByLanguage<CR>

" Other:
" :BarbarEnable - enables barbar (enabled by default)
" :BarbarDisable - very bad command, should never be used

let bufferline = get(g:, 'bufferline', {})
let bufferline.animation = v:false " disable/enable animation
let bufferline.closable = v:false " disable/enable close button
let bufferline.clickable = v:false " disable/enable clickable tabs

" Enable/disable icons
" if set to 'numbers', will show buffer index in the tabline
" if set to 'both', will show buffer index and icons in the tabline
let bufferline.icons = 'both'

let bufferline.icon_custom_colors = v:true

function! s:fg(group)
    let hl = nvim_get_hl_by_name(a:group, 1)
    return printf("#%06x", hl.foreground)
endfunction

let s:bg0 = s:fg("GruvboxBg0")
let s:bg1 = s:fg("GruvboxBg1")
let s:bg2 = s:fg("GruvboxBg2")
let s:bg4 = s:fg("GruvboxBg4")
let s:fg1 = s:fg("GruvboxFg1")
let s:fg4 = s:fg("GruvboxFg4")
let s:red = s:fg("GruvboxRed")
let s:orange = s:fg("GruvboxOrange")
let s:blue = s:fg("GruvboxBlue")
let s:yellow  = s:fg("GruvboxYellow")
let s:purple = s:fg("GruvboxPurple")
let s:aqua = s:fg("GruvboxAqua")
let s:green = s:fg("GruvboxGreen")
let s:gray = s:fg("GruvboxGray")

execute "hi BufferCurrent gui=bold guifg=" . s:fg1 . " guibg=" . s:bg2
execute "hi BufferCurrentIndex guifg=" . s:fg4 . " guibg=" . s:bg2
execute "hi BufferCurrentMod gui=bold guifg=" . s:yellow . " guibg=" . s:bg2
execute "hi BufferCurrentSign guifg=" . s:fg4 . " guibg=" . s:bg2
execute "hi BufferCurrentTarget gui=bold guifg=" . s:red . " guibg=" . s:bg2

execute "hi BufferVisible guifg=" . s:blue . " guibg=" . s:bg1
execute "hi BufferVisibleIndex guifg=" . s:blue . " guibg=" . s:bg1
execute "hi BufferVisibleMod guifg=" . s:yellow . " guibg=" . s:bg1
execute "hi BufferVisibleSign guifg=" . s:blue . " guibg=" . s:bg1
execute "hi BufferVisibleTarget gui=bold guifg=" . s:red . " guibg=" . s:bg1

execute "hi BufferInactive guifg=" . s:bg4 . " guibg=" . s:bg1
execute "hi BufferInactiveIndex guifg=" . s:bg2 . " guibg=" . s:bg1
execute "hi BufferInactiveMod guifg=" . s:yellow . " guibg=" . s:bg1
execute "hi BufferInactiveSign guifg=" . s:bg2 . " guibg=" . s:bg1
execute "hi BufferInactiveTarget gui=bold guifg=" . s:red . " guibg=" . s:bg1

execute "hi BufferTabpages gui=bold guifg=" . s:orange . " guibg=" . s:bg1
execute "hi BufferTabpageFill guifg=" . s:bg4 . " guibg=" . s:bg1

execute "hi link BufferCurrentIcon  BufferCurrent"
execute "hi link BufferVisibleIcon BufferVisible"
execute "hi link BufferInactiveIcon BufferInactive"
