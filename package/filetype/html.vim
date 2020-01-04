
Plug 'chemzqm/wxapp.vim'
Plug 'wavded/vim-stylus'
Plug 'groenewege/vim-less'
Plug 'kchmck/vim-coffee-script'

au BufRead,BufNewFile,BufReadPre *.coffee   set filetype=coffee

Plug 'jparise/vim-graphql'
" Plug 'HerringtonDarkholme/yats.vim'

Plug 'mxw/vim-jsx'
" let g:jsx_ext_required = 1
Plug 'pangloss/vim-javascript'
Plug 'posva/vim-vue'
Plug 'dart-lang/dart-vim-plugin'

" setlocal indentkeys+=0.
" make build work better
" autocmd QuickFixCmdPost [^l]* nested cwindow
" autocmd QuickFixCmdPost    l* nested lwindow


" Plug 'maksimr/vim-jsbeautify' , { 'do': 'git submodule update --init --recursive' }
"
" com! -nargs=0 JS call JsBeautify() | setf javascript
" com! -nargs=0 CSS call CSSBeautify() | setf css
" com! -nargs=0 HTML call HtmlBeautify() | setf html
com! -nargs=0 JSON %!python -m json.tool

set inex=FindRoot(v:fname)
set isfname+=@-@

fun! CheckValid(path, ext, idx)
    let path = a:path
    let ext = a:ext
    let idx = a:idx
    " echom path . ext
    " echom filereadable(path . ext )
    " echom path . idx
    " echom filereadable(path . idx )
    if filereadable(path . ext )
        return [1, path . ext]
    elseif filereadable(path . idx)
        return [2, path . idx]
    elseif isdirectory(path )
        return [3, path ]
    else
        return [0,0]
    endif
endfun
fun! FindRoot(name)
    if (a:name =~ '^@' )
        let path = substitute(a:name,'^@','src','') 
    else
        let path = 'node_modules/' . a:name 
    endif

    let ext = '.js'
    let idx = '/index.js'
    let i = 0
    let full = CheckValid(path, ext, idx)
    while i < 5
        let path = '../'. path
        let i+=1
        let full = CheckValid(path, ext, idx)

        if full[0] != 0
            return full[1]
        endif
    endwhile
endfun

Plug 'mattn/emmet-vim'

let g:user_emmet_settings       = { 
    \ 'indentation' : '    ',
    \ 'vue': {
    \ 'extends' : 'html'
    \}}
let g:user_emmet_leader_key     = '<c-f>'
let g:user_emmet_expandabbr_key = '<c-f>f'    "e
let g:user_emmet_expandword_key = '<c-f>F'    "e
let g:user_emmet_next_key       = '<c-f>j'    "n
let g:user_emmet_prev_key       = '<c-f>k'    "p
let g:user_emmet_removetag_key  = '<c-f>d'    "k




aug au_emmet_vue
    au!
    " au BufRead,BufNewFile *.vue setf vue
    " autocmd BufRead,BufNewFile *.vue setlocal filetype=vue.html.javascript.css.scss
    autocmd BufRead,BufNewFile *.vue setlocal filetype=vue
    " autocmd BufRead,BufNewFile *.vue setlocal includeexpr=LoadMainNodeModule(v:fname)
    
    " au FileType vue imap <tab> <plug>(emmet-expand-abbr)
    au FileType vue setl sw=2
aug END





Plug 'cakebaker/scss-syntax.vim'
au BufRead,BufNewFile *.scss set filetype=scss.css
au FileType scss set iskeyword+=-


Plug 'maksimr/vim-jsbeautify' , { 'do': 'git submodule update --init --recursive' }




Plug 'AndrewRadev/inline_edit.vim'
    " normal mode:
    nnoremap <leader>ee :InlineEdit<cr>

    " visual mode:
    xnoremap <leader>ee :InlineEdit<cr>

    " insert mode:
    inoremap <c-e>e <esc>:InlineEdit<cr>a

