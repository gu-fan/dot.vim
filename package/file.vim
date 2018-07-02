
Plug 'scrooloose/nerdtree'
let g:NERDTreeQuitOnOpen=1
let g:NERDTreeShowHidden=1
let g:NERDTreeShowBookmarks = 0
let g:NERDTreeWinPos = 'right'
let NERDTreeIgnore=['\~$', '.meta$[[file]]']

aug au_NERD
    au!
    " NERDTREE AUTO REFRESH
    au BufWritePost * 
        \ if type(g:NERDTree.ForCurrentTab()) != 0 |
        \ call g:NERDTree.ForCurrentTab().getRoot().refresh() |
        \ endif
aug END

Plug 'kien/ctrlp.vim'
" nmap <C-J>  :CtrlPLine<CR>
let g:ctrlp_custom_ignore =  {
    \ 'dir':  '\v[\/](\.(git|hg|svn)|node_modules)$'
    \ }
let g:ctrlp_use_cache = 0
let g:ctrlp_root_markers=['.git', 'package.json', 'package.vim']
" let g:ctrlp_user_command = 'ag %s -l --nocolor --hidden -g ""'


fun! V(...)
    CtrlPMRU
    if a:0
        call feedkeys(a:1)
    endif
endfun
com! -nargs=* V call V(<q-args>)
map <leader>pv  :CtrlPMRU<CR>
map <leader>pl  :CtrlPLine<CR>
map <leader>pp  :CtrlP<CR>

