
let g:path={}
let g:path.dot = expand('~/.dot.vim/')
let g:path.plug = expand('~/.vim/plugged/')

exec "so ".  g:path.dot. "package.vim"

