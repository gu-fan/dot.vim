" Choosing workspaces
nmap <leader>ww :call <SID>choose()<CR>
nmap <leader>w1 :call <SID>work.client()<cr>
nmap <leader>w2 :call <SID>work.server()<cr>
nmap <leader>w3 :call <SID>work.crawl()<cr>
nmap <leader>w4 :call <SID>work.model()<CR>
nmap <leader>w5 :call <SID>work.docker()<CR>

let s:app4 = expand('~/Desktop/HStack/R0/app4/')
let s:vim = expand('~/.vim/plugged/')

fun! s:choose() abort
    let funcs = keys(s:work) 
    let input  = extend(['select workspace', ' ' ], map(copy(funcs), "(v:key+1) . '. ' . v:val"))
    let choose = inputlist(input)

    if (choose <= 0)
    else
        call s:work[funcs[choose-1]]()
    endif
endfun

let s:work = {}



fun! s:cmd()
    if expand('%') == '' && bufnr('%') == 1
        let cmd = 'e '
    else
        let cmd = 'tabnew '
    endif
    return cmd
endfun
 
fun! s:work.server() abort
    exec s:cmd() . s:app4 . 'search/src/services/swamp.service.js'
    exec 'vs ' . s:app4 . 'search/src/route/index.js'
endfun

fun! s:work.crawl() abort
    exec s:cmd() . s:app4 . 'worker/crawl/crawl.js'
    exec 'vs ' . s:app4 . 'worker/crawl/parser.js'
endfun

fun! s:work.client() abort
    exec s:cmd() . s:app4 . 'search/src/services/swamp.service.js'
    exec 'vs ' . s:app4 . 'dashboard/d1/src/pages/Main.vue'
    syntax sync fromstart
    " exec 'sp ' . s:app4 . 'dashboard/d1/src/main.js'
endfun

fun! s:work.user() abort
    exec s:cmd() . s:app4 . 'server/src/route/index.js'
    exec 'vs ' . s:app4 . 'client/w1/src/pages/Main.vue'
    syntax sync fromstart
endfun

fun! s:work.model() abort
    exec s:cmd() . s:app4 . 'search/src/models/index.js'
    exec 'vs ' . s:app4 . 'search/migrations/'
endfun

fun! s:work.docker() abort
    exec s:cmd() . s:app4 . 'database/README.rst'
endfun


" fun! s:work.vim() abort
"     exec s:cmd() . s:vim . 'simpleui.vim/index.vim'
"     vs ~/.dot.vim/index.vim
" endfun
