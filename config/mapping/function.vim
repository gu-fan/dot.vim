function! s:escape(p,mode) "{{{
    " escape word
    if a:mode =~ "s"
        let re_txt =  ''
    elseif a:mode =~ "e"
        let re_txt =  '*[]/~.$\'
    elseif a:mode =~ "r"
        let re_txt =  '&'
    endif
    return escape(a:p,re_txt)
endfunction "}}}
function! s:p(p,mode) "{{{
    if a:mode =~ "s"
        let re_txt =  ''
    elseif a:mode =~ "e"
        let re_txt =  '*[]/~.$\'
    elseif a:mode =~ "r"
        let re_txt =  '&'
    endif
    return escape(a:p,re_txt)
endfunction "}}}
function! s:r() "{{{
    normal gv"yy
    let w = @y
    return w
endfunction "}}}
function! s:w(s,mode) "{{{
    let rs = a:s
    if a:mode =~ "b"
        let ss = "\\<".s:p(a:s,"s")."\\>"
    else
        let ss = s:p(a:s,"s")
    endif
    return 's/'.ss."/".s:p(rs,"r")."/gc"
endfunction "}}}

function! s:substitute(s,mode) "{{{
    " get the substitute part
    let rs = a:s
    if a:mode =~ "b"
        let ss = "\\<".s:escape(a:s,"s")."\\>"
    else
        let ss = s:escape(a:s,"s")
    endif
    return 's/'.ss."/".s:escape(rs,"r")."/gc"
endfunction "}}}

let s:k = require.at('search', expand('<sfile>:p'))
" Require search

vno   /    <ESC>/<C-\>e<SID>p(<SID>r(),"e")<CR>
vno   ?    <ESC>?<C-\>e<SID>p(<SID>r(),"e")<CR>
vno   #    <ESC>/<C-\>e<SID>p(<SID>r(),"e")<CR><CR><C-G>
vno   *    <ESC>?<C-\>e<SID>p(<SID>r(),"e")<CR><CR><C-G>
vno   n    <ESC>/<C-\>e<SID>p(<SID>r(),"e")<CR><CR><C-G>
vno   N    <ESC>?<C-\>e<SID>p(<SID>r(),"e")<CR><CR><C-G>

augroup help
    autocmd!
    au BufRead,BufNewFile *.vim set kp=
    au FileType vim set kp=
    au FileType bash set kp=man
augroup END

nor   <F1>   K
" nno   <s-F2> :%<C-R>=<SID>substitute(@/,"\x00")<CR><Left><Left><Left>
" vno   <s-F2> :<C-R>=<SID>substitute(@/,"\x00")<CR><Left><Left><Left>
" nno   <F2>   :%<C-R>=<SID>substitute(expand('<cword>'),"b")<CR><Left><Left><Left>
" vno   <F2>   :<C-R>=<SID>substitute(expand('<cword>'),"b")<CR><Left><Left><Left>
nno   <F2>     :%<C-R>=<SID>w(@/,"\x00")<CR><Left><Left><Left>
vno   <F2>     :<C-R>=<SID>w(@/,"\x00")<CR><Left><Left><Left>
nno   <S-F2>   :%<C-R>=<SID>w(expand('<cword>'),"b")<CR><Left><Left><Left>
vno   <S-F2>   :<C-R>=<SID>w(expand('<cword>'),"b")<CR><Left><Left><Left>

" TODO: use c_Ctrl-\_e to finish this.
" XXX
" % can not be used.
" nno   <s-F1> :%<C-\>e<SID>sub2(expand('<cword>'),"\x00")<CR>

imap  <F2>   <C-O>:set paste<CR>
imap  <F3>   <C-O>:set nopaste<CR>

"{{{3 F3 Ack-grep http://better-than-grep.com
" exists ag or grep
nor   <S-F3>     :Ag <C-R><C-F> %<CR>
vno   <S-F3>     y:Ag <C-R>" %<CR>
nor   <F3>   :Ag 
vno   <F3>   y:Ag <C-R>"<CR>

"{{{3 F4 Folder
nno <silent> <F4> :call <SID>toggle_nerdfind()<CR>
nno <silent> <C-T> :call <SID>toggle_nerdfind()<CR>
nno <silent> <F5> :call <SID>exe("n")<CR>
vno <silent> <F5> :call <SID>exe("v")<CR>

com! -nargs=0 Dir call <SID>file_man('')
com! -nargs=0 Term call <SID>terminal()

nor   <F7>   :GundoToggle<CR>
nor   <F8>   :Dir<CR>
nor   <F6>   :Shell<CR>

function! s:toggle_nerdfind() "{{{
    if exists("t:nerdwin") && t:nerdwin==1
        NERDTreeClose
        let t:nerdwin=0
    else
        NERDTreeFind
        let t:nerdwin=1
    endif
endfunction "}}}


function! s:exe(mode) "{{{
    update
    let bang="!"
    if g:_v.is_mac
        let browser = 'open -a "Google Chrome" -g'
        let runner="open "
        let err_log=" "
        let term = "iTerm "
    elseif g:_v.is_unix
        let browser = "firefox "
        let runner="xdg-open "
        let err_log=" 2>&1 | tee /tmp/.vim_exe.tmp"
        let term = "gnome-terminal "
    else
        let browser ="firefox.lnk "
        let runner="start "
        let err_log=" "
        let term = "cmd "
    endif

    if !exists("&syn")
        exec bang.runner.file
        return
    else
        let syn=&syn
    endif

    if a:mode=="n"
        let file=' "'.expand('%:p').'"'
        if    syn=="python"
            let    L=getline(1)
            if     L=~'python3' | exec "!python3 -d ".file.err_log
            elsei  L=~'pyfile'
                if has("python")
                    pyfile %
                else
                    exec "!python -d ".file.err_log
                endif
            elsei  L=~'pypy'    | exec "!pypy -d ".file.err_log
            else                | exec "!python -d ".file.err_log
            endif
        elsei syn=="ruby"
            if has("ruby")
                rubyfile %:p
            else
                exec "!ruby ".file.err_log
            endif
        elsei syn=="perl"       | exec "!perl -D ".file.err_log
        elsei syn=="lua"        | exec "luafile %"
        elsei syn=='vim'        | exec "so %"
        elsei syn=='plantuml'   | silent make
        elsei syn=~'html'       | exec bang.browser.file
        elsei syn=='rst'        | Riv2HtmlAndBrowse
        elsei syn=~'^coffee$'   | exec "CoffeeRun"
        elsei syn=="vimwiki"    | exec "Vimwiki2HTMLBrowse"
        elsei syn=='bat'        | exec "w !cmd"
        elsei syn=='javascript' | exec "Dispatch node %"
        elsei syn=='go'         | exec "!go run %"
        elsei syn=='make'       | make
        elsei syn=='haskell'    | exec "!ghc %" | exec "!./%:t:r"
        elsei syn=='cpp' || syn=='c' | call s:gcp()  | exec "!./%:t:r"
        elsei syn=~'^\(sh\|expect\|bash\)$'     | exec "w !sh"
        else                    | exec bang.runner.file
        endif
    elseif a:mode=="v"
        if     syn=="python"    | exec "py ".getline('.')
        elseif syn=="ruby"      | exec "ruby ".getline('.')
        elseif syn=="lua"       | exec "lua".getline('.')
        elseif syn=='vim'       | exec getline('.')
        elseif syn=~'^\(sh\|expect\|bash\)$'    | exec ".w !sh"
        endif
    endif
endfunction "}}}
function! s:gcp() "{{{
    let lf = ''
    for l in getline(1,10)
        if l =~ 'gtk\|gdk'
            let lf .= 'g'
        endif
        if l =~ 'math'
            let lf .= 'm'
        endif
    endfor
    let lib=''
    if lf =~ 'g'
        let lib .=' `pkg-config --cflags --libs gtk+-2.0` '
    endif
    if lf =~ 'm'
        let lib .= ' -lm '
    endif
    exec "!gcc -Wall " . lib . " -o %:t:r %"
endfunction "}}}
function! s:file_man(mode) "{{{
    if g:_v.is_windows
        sil exec '!start explorer "%:p:h"'
    elseif g:_v.is_mac
        sil exec "!open '%:p:h'"
    else
        sil exec "!".a:mode."nautilus '%:p:h' & "
    endif
endfunction "}}}
function! s:terminal() "{{{
    if _v.is_windows | exec '!start cmd "%:p:h"'
    else            | exec "!urxvt -cd %:p:h &"
    endif
endfunction "}}}
