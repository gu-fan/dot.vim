set ff=unix
set encoding=utf-8
set termencoding=utf-8
set fileencoding=utf-8
set fileencodings=ucs-bom,utf-8
scriptencoding utf-8
language messages en_US.utf-8


set sua+=.js,.css,.html,index.js,/index.js,index.vim,.vim
set path+=~/.vim/plugged/,~/.dot.vim/



set nopaste
set pastetoggle=<F2>
set autoread                    " update a open file edited outside of Vim
set ttimeoutlen=0               " toggle between modes almost instantly

set backspace=indent,eol,start  " defines the backspace key behavior
" set virtualedit=all             " to edit where there is no actual character
set virtualedit=block             " to edit where there is no actual character


" Tabs, space and wrapping
set expandtab                  " spaces instead of tabs
set tabstop=4                  " a tab = four spaces
set shiftwidth=4               " number of spaces for auto-indent
set softtabstop=4              " a soft-tab of four spaces
set autoindent                 " set on the auto-indent
set smartindent                " indent on some case


if has('unnamedplus')
    set clipboard=autoselectplus,unnamedplus,exclude:cons\|linux
else
    set clipboard=autoselect,unnamed
endif
