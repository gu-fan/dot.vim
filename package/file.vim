
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

Plug 'Shougo/denite.nvim'

call denite#custom#option('default', 'prompt', '> ')
"call denite#custom#option('default', 'direction', 'bottom')
call denite#custom#option('default', 'empty', 0)
call denite#custom#option('default', 'auto_resize', 1)
call denite#custom#option('default', 'auto_resume', 1)
call denite#custom#filter('matcher_ignore_globs', 'ignore_globs',
  \ [ '.git/', '.ropeproject/', '__pycache__/', '*.min.*', 'fonts/'])
" Change file_rec command.
call denite#custom#var('file_rec', 'command',
  \ ['rg', '--color', 'never', '--files'])
" buffer
call denite#custom#var('buffer', 'date_format', '')
call denite#custom#source('buffer', 'matchers', ['matcher/fuzzy', 'matcher/project_files'])
" Change grep options.
call denite#custom#var('grep', 'command', ['rg'])
call denite#custom#var('grep', 'default_opts',
    \ ['--vimgrep', '--no-follow'])
call denite#custom#var('grep', 'recursive_opts', [])
call denite#custom#var('grep', 'pattern_opt', [])
call denite#custom#var('grep', 'separator', ['--'])
call denite#custom#var('grep', 'final_opts', [])
" Change file_rec matcher
call denite#custom#source('line', 'matchers', ['matcher_regexp'])
call denite#custom#source('file_rec, redis_mru', 'sorters', ['sorter/sublime'])


" Change mappings.
call denite#custom#map(
      \ 'insert',
      \ '<C-a>',
      \ '<denite:move_caret_to_head>',
      \ 'noremap'
      \)

call denite#custom#map(
      \ 'insert',
      \ '<C-j>',
      \ '<denite:move_to_next_line>',
      \ 'noremap'
      \)

call denite#custom#map(
      \ 'insert',
      \ '<C-k>',
      \ '<denite:move_to_previous_line>',
      \ 'noremap'
      \)

call denite#custom#map(
      \ 'insert',
      \ '<C-s>',
      \ '<denite:do_action:vsplit>',
      \ 'noremap'
      \)

call denite#custom#map(
      \ 'insert',
      \ '<C-t>',
      \ '<denite:do_action:tabopen>',
      \ 'noremap'
      \)

call denite#custom#map(
      \ 'insert',
      \ '<C-d>',
      \ '<denite:do_action:delete>',
      \ 'noremap'
      \)

call denite#custom#map(
      \ 'insert',
      \ '<C-b>',
      \ '<denite:scroll_page_backwards>',
      \ 'noremap'
      \)

call denite#custom#map(
      \ 'insert',
      \ '<C-f>',
      \ '<denite:scroll_page_forwards>',
      \ 'noremap'
      \)

call denite#custom#map(
      \ 'insert',
      \ '<C-p>',
      \ '<denite:print_messages>',
      \ 'noremap'
      \)

call denite#custom#map(
      \ 'normal',
      \ '<C-j>',
      \ '<denite:wincmd:j>',
      \ 'noremap'
      \)

call denite#custom#map(
      \ 'normal',
      \ '<C-k>',
      \ '<denite:wincmd:k>',
      \ 'noremap'
      \)

call denite#custom#map(
      \ 'normal',
      \ '<esc>',
      \ '<denite:quit>',
      \ 'noremap'
      \)

call denite#custom#map(
      \ 'normal',
      \ 'a',
      \ '<denite:do_action:add>',
      \ 'noremap'
      \)

call denite#custom#map(
      \ 'normal',
      \ 'd',
      \ '<denite:do_action:delete>',
      \ 'noremap'
      \)

call denite#custom#map(
      \ 'normal',
      \ 'r',
      \ '<denite:do_action:reset>',
      \ 'noremap'
      \)

call denite#custom#map(
      \ 'normal',
      \ 's',
      \ '<denite:do_action:vsplit>',
      \ 'noremap'
      \)

call denite#custom#map(
      \ 'normal',
      \ 'e',
      \ '<denite:do_action:edit>',
      \ 'noremap'
      \)

call denite#custom#map(
      \ 'normal',
      \ 'h',
      \ '<denite:do_action:help>',
      \ 'noremap'
      \)

call denite#custom#map(
      \ 'normal',
      \ 'u',
      \ '<denite:do_action:update>',
      \ 'noremap'
      \)

call denite#custom#map(
      \ 'normal',
      \ 'f',
      \ '<denite:do_action:find>',
      \ 'noremap'
      \)

