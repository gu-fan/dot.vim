let plugfile = expand('~/.vim/autoload/plug.vim')

if !filereadable(plugfile)
    echom "Start download plug.vim"
    exec "!curl -fLo ~/.vim/autoload/plug.vim --create-dirs ".
        \ " https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
    echom "Restart vim to active plug.vim"
    finish
endif

call plug#begin('~/.vim/plugged')

Plug 'gu-fan/require.vim'
exec "so ".  g:path.plug. "require.vim/plugin/require.vim"

Plug 'gu-fan/os.vim'
exec "so ".  g:path.plug. "os.vim/plugin/os.vim"

Plug 'gu-fan/debug.vim'
Plug 'Shougo/vimproc.vim', {'do' : 'make'}


Require 'config/editor'

Require 'config/autocmd'
Require 'config/statusline'
Require 'config/command'
Require 'config/mapping'
Require 'config/folding'
Require 'config/history'
Require 'config/search'
Require 'config/workspace'




if os.is_windows
    Require 'config/mswin'
endif




Require 'package/ui'
Require 'package/history'
Require 'package/search'
Require 'package/complete'

Require 'package/document'
Require 'package/shell'

Require 'package/filetype/html'

" Plug 'rykka/jass.vim'
" Plug 'rykka/mathematic.vim'
" Plug 'rykka/zendjango.vim'

Require 'package/mapping'


" Plug 'vim-airline/vim-airline-themes'
" Plug 'vim-airline/vim-airline'


Require 'package/file'
Require 'package/git'

" Plug 'wakatime/vim-wakatime'


call plug#end()

Require 'config/ui'
