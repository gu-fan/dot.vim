let g:path={}
let g:path.dot = expand('/Users/gu_fan/.dot.vim/')
let g:path.plug = expand('/Users/gu_fan/.vim/plugged/')

set path+=/usr/local/bin

" deoplete need python3 , and python3 is confilc  with python2
set pythondll=
set pythonthreehome=/Library/Frameworks/Python.framework/Versions/3.8
set pythonthreedll=/Library/Frameworks/Python.framework/Versions/3.8/lib/libpython3.8.dylib

exec "so ".  g:path.dot. "package.vim"

" ~/.vim/plugged/require.vim/plugin/require.vim

" ~/.vim/plugged/simpleterm.vim/plugin/simpleterm.vim
" ~/.vim/plugged/simpletodo.vim/plugin/simpletodo.vim
" ~/.vim/plugged/simplecolor.vim/plugin/simplecolor.vim
"
" ~/.vim/plugged/simpleui.vim/index.vim

" the navigation as autojump in vim is still a problem
" maybe ctrlp+mru ? 
"
" the terminal integration need buffer specific command
" will greatly improve workflow
"
" rgba(  4, 32,124,0.5)
"
" others
"
" ~/.itermocil/
"
" ~/.zshrc
"
" ~/.config/fish/fish.config
" ~/.config/omf/init.fish
set mmp=100000
" cd /Users/gu_fan/nuts/wiki_new
set bo=all
" let $SSH_ASKPASS = simplify($VIM . '/../../MacOS') . '/macvim-askpass'
"
" :h terminal
let g:terminal_ansi_colors = 
            \['#616161', '#f08978', '#c3f884', '#fefdc8', '#afd4fa', '#f295f7', '#d0d1fa', '#f1f1f1'
            \,'#8e8e8e', '#f7c6bf', '#ddfbc0', '#fefdd9', '#c8e2fc', '#f5b5f9', '#e5e6fc', '#fffeff']
