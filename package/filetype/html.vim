" vim:sw=2
Plug 'chemzqm/wxapp.vim'
" Plug 'wavded/vim-stylus'
Plug 'groenewege/vim-less'
Plug 'kchmck/vim-coffee-script'

au BufRead,BufNewFile,BufReadPre *.coffee   set filetype=coffee

Plug 'jparise/vim-graphql'
" Plug 'HerringtonDarkholme/yats.vim'

" Plug 'mxw/vim-jsx'
" let g:jsx_ext_required = 1
Plug 'pangloss/vim-javascript'
" Plug 'leafOfTree/vim-vue-plugin'    " it's too slow, though indent is
" provided
" Plug 'posva/vim-vue'
" Plug 'iloginow/vim-stylus'

" let g:vue_pre_processors = ['pug', 'stylus']
" let g:vue_pre_processors = 'detect_on_enter'
" Plug 'leafgarland/typescript-vim'
" Plug 'HerringtonDarkholme/yats.vim'
"
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

" 解决js 文件 gf跳转的问题
Plug 'tpope/vim-apathy'
aug au_js "{{{
    au!
aug END "}}}
nmap gj :echo FindRoot(expand('<cfile>'))<CR>

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
    echoe path
let path = 'node_modules/' . a:name 

    let ext = '.js'
    let idx = '/index.js'
    let i = 0
    let full = CheckValid(path, ext, idx)
    echoe full
    while i < 5
        let path = '../'. path
        let i+=1
        let full = CheckValid(path, ext, idx)

        if full[0] != 0
            return full[1]
        endif
    endwhile
endfun

aug au_js "{{{
    au!
    au FileType javascript,vue nmap <silent><buffer> gf :call GoFile(expand('<cfile>'), @%)<CR>
    au FileType javascript,vue nmap <silent><buffer> <A-LeftMouse> :call GoFile(expand('<cfile>'), @%, 'a-l')<CR>
    au FileType javascript,vue nmap <silent><buffer> <c-w>s :call GoFile(expand('<cfile>'), @%, 'sp')<CR>
    au FileType javascript,vue nmap <silent><buffer> <c-w><c-s> :call GoFile(expand('<cfile>'), @%, 'sp')<CR>
    au FileType javascript,vue nmap <silent><buffer> <c-w>v :call GoFile(expand('<cfile>'), @%, 'vs')<CR>
    au FileType javascript,vue nmap <silent><buffer> <c-w><c-v> :call GoFile(expand('<cfile>'), @%, 'vs')<CR>
aug END "}}}

function! GoFile(target, current, ...) abort
  let target = FindFile(a:target, a:current)
  if filereadable(target)
    if a:0
      if a:1 == '2-l'
        exec "e " . target
      else
        exec a:1. " " . target
      endif
    else
      exec "e " . target
    endif
  else
    if a:0
      if a:1 == 'a-l'
        exe "norm! \<A-LeftMouse>"
      else
        exec a:1
      endif
    endif
    echom "Can't find file '" . a:target . "' in path"
  endif
endfunction
" echo match('a require( "test"', includeReg)
" echo match('import xxxx from "aaaa"', includeReg)
function! CheckPathExist(target) 
  let target = a:target
  if filereadable(target)
      return target
  endif
  if isdirectory(target)
    let idx_tar = target . '/index.js'
    if filereadable(idx_tar)
        return idx_tar
    endif
  else
    let suff_tar = target . '.js'
    if filereadable(suff_tar)
        return suff_tar
    endif
  endif
  return ''
endfun
function! FindFile(target, current) abort
  let line = getline(".")
  let includeReg = '\(\<require\s*(\s*[''"]\zs.*\ze[''"]\|import.*\<from\s*[''"]\zs.*\ze[''"]\)'
  if match(line, includeReg) == -1
    return
  endif

  " 保证光标位置在文件名中
  let startReg = '\(\<require\s*(\s*[''"]\zs\|import.*\<from\s*[''"]\zs\)'
  let endReg = '\(\<require\s*(\s*[''"][^''"]*\zs[''"]\|import.*\<from\s*[''"][^''"]*\zs[''"]\)'
  let start = match(line, startReg)
  let end = match(line, endReg)
  let col = getpos('.')[2]
  if col < start || col > end
    return
  endif


  let target = substitute(a:target, '^\~[^/]\@=', '', '')
  let target = substitute(target, '^@[/]\@=', '', '')
  if target =~# '^\.\.\=/'
    let target = simplify(fnamemodify(resolve(a:current), ':p:h') . '/' . target)
  endif

  " check if it's dir or file
  " xxxx/xxxx
  let _tar = CheckPathExist(target)
  if len(_tar)
    return _tar
  endif


  " check if it's package in node_modules
  " package.json-/node_modules/xxx/xxxx
  let path = split(&path, ',')[0]
  let node_dir = path . '/' . target 
  if isdirectory(node_dir)
    let pkg_file = node_dir.'/package.json'
     if filereadable(node_dir.'/package.json')
      try
        let package = json_decode(join(readfile(pkg_file)))
        let target = node_dir . '/' . get(package, 'main', 'index.js')
      catch
      endtry
     endif
  endif

  " we may should check it's in NODE_PATH

  " check if its based in project root
  " root/xxxx/xxxx
  let root_dir = fnamemodify(path, ':p:h:h')
  let root_path = root_dir . '/' . target
  let _tar = CheckPathExist(root_path)
  if len(_tar)
    return _tar
  endif


  " check if it's in the 
  " root/src/xxxx/xxxx
  let roo_src_path = root_dir . '/src/' . target
  let _tar = CheckPathExist(roo_src_path)
  if len(_tar)
    return _tar
  endif

  echom target




  return target
endfunction





Plug 'mattn/emmet-vim'

let g:user_emmet_settings       = { 
    \ 'indentation' : '  ',
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
au BufNewFile,BufRead *.html,*.js,*.vue set tabstop=2
au BufNewFile,BufRead *.html,*.js,*.vue set softtabstop=2
au BufNewFile,BufRead *.html,*.js,*.vue set shiftwidth=2
au BufNewFile,BufRead *.html,*.js,*.vue set expandtab
au BufNewFile,BufRead *.html,*.js,*.vue set autoindent
au BufNewFile,BufRead *.html,*.js,*.vue set fileformat=unix
autocmd FileType vue syntax sync fromstart 
au BufNewFile,BufRead *.styl set syntax=less
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

