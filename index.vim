let g:path={}
let g:path.dot = expand('~/.dot.vim/')
let g:path.plug = expand('~/.vim/plugged/')
exec "so ".  g:path.dot. "package.vim"

Require config/editor

Require config/ui
Require config/autocmd
Require config/statusline
Require config/command
Require config/mapping
Require config/folding
Require config/history
Require config/search

if os.is_windows
    Require config/mswin
endif


