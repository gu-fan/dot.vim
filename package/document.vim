Plug 'gu-fan/simpletodo.vim'
Plug 'rykka/riv.vim'

let proj2 = {'path': '~/nuts/riv/'}
let proj3 = {'path': '~/Dropbox/wiki/'}
let proj1 = {'path': '~/nuts/wiki_new/'}
let proj4 = {'path': '~/test/sphinx/'}

let g:riv_projects = [proj1, proj2, proj3, proj4]
" XXX: This should be set as a project option.
let g:riv_todo_datestamp = 0
let g:riv_file_link_style = 2

Plug 'rykka/autotype.vim'
" Plug 'rykka/os.vim'
" Plug 'rykka/clickable.vim'
" let g:clickable_browser = 'google chrome'
" Plug 'rykka/clickable-things'
" Plug 'rykka/autotype.vim'
Plug 'rykka/InstantRst'

" Plug 'vim-jp/vital.vim'

Plug 'mattn/webapi-vim'
Plug 'rykka/trans.vim'

" This api is much faster.
let g:trans_default_api = 'youdao'
let g:trans_map_trans = '<localleader>tt'
