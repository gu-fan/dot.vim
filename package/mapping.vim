
Plug 'Lokaltog/vim-easymotion'
let g:EasyMotion_startofline = 0 " keep cursor colum when JK motion
" map <Leader> <Plug>(easymotion-prefix)
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

