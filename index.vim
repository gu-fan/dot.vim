so <sfile>:p:h/package.vim
" package.vim

" ~/vim-box/vimrc

Require config/editor

Require config/ui
Require config/autocmd
Require config/command
Require config/mapping
Require config/folding
Require config/history
Require config/search

if os.is_windows
    Require config/mswin
endif


