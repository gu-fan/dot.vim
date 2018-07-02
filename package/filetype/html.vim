
Plug 'chemzqm/wxapp.vim'
Plug 'wavded/vim-stylus'

Plug 'jparise/vim-graphql'
" Plug 'leafgarland/typescript-vim'
Plug 'HerringtonDarkholme/yats.vim'

setlocal indentkeys+=0.
" make build work better
autocmd QuickFixCmdPost [^l]* nested cwindow
autocmd QuickFixCmdPost    l* nested lwindow
