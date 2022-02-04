
Plug 'Lokaltog/vim-easymotion'
let g:EasyMotion_startofline = 0 " keep cursor colum when JK motion
" map <Leader> <Plug>(easymotion-prefix)
let g:EasyMotion_do_mapping = 0
map <Leader> <Nop>
" Gif config
"
nmap f <Plug>(easymotion-s)
nmap F <Plug>(easymotion-s)
nmap t <Plug>(easymotion-t)
" " Gif config
" map  / <Plug>(easymotion-sn)
" omap / <Plug>(easymotion-tn)

" " These `n` & `N` mappings are options. You do not have to map `n` & `N` to EasyMotion.
" " Without these mappings, `n` & `N` works fine. (These mappings just provide
" " different highlight method and have some other features )
" map  n <Plug>(easymotion-next)
" map  N <Plug>(easymotion-prev)

" nmap s <Plug>(easymotion-s)
" Bidirectional & within line 't' motion
omap t <Plug>(easymotion-bd-tl)
" Use uppercase target labels and type as a lower case
let g:EasyMotion_use_upper = 1
 " type `l` and match `l`&`L`
let g:EasyMotion_smartcase = 1
" Smartsign (type `3` and match `3`&`#`)
let g:EasyMotion_use_smartsign_us = 1



Plug 'tommcdo/vim-lion'

com! -nargs=0 Align :norm glip=
com! -nargs=0 Al2 :norm gLip=


" " vim 输入法切换
Plug 'rlue/vim-barbaric'
" The IME to invoke for managing input languages (macos, fcitx, ibus, xkb-switch)
let g:barbaric_ime = 'macos'

" The input method for Normal mode (as defined by `xkbswitch -g`, `ibus engine`, or `xkb-switch -p`)
let g:barbaric_default = 1

" The scope where alternate input methods persist (buffer, window, tab, global)
let g:barbaric_scope = 'buffer'

" Forget alternate input method after n seconds in Normal mode (disabled by default)
" Useful if you only need IM persistence for short bursts of active work.
let g:barbaric_timeout = -1

" The fcitx-remote binary (to distinguish between fcitx and fcitx5)
" let g:barbaric_fcitx_cmd = 'fcitx5-remote'

" The xkb-switch library path (for Linux xkb-switch users ONLY)
" let g:barbaric_libxkbswitch = $HOME . '/.local/lib/libxkbswitch.so'
"
" Plug 'ybian/smartim'

" let g:smartim_default='com.apple.keylayout.ABC'
inoremap <c-c> <esc>
