" ack.vim config
cnoreabbrev Ack Ack!
nnoremap <C-\> :Ack!<space>

if executable('rg')
    let g:ackprg='rg --vimgrep --no-heading'
endif
