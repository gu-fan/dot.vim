
Plug 'sjl/gundo.vim'

" Open Last closed window
Plug 'rykka/lastbuf.vim'


" save/load last workspace
Plug 'tpope/vim-obsession'

set ssop=blank,curdir,help,options,resize,tabpages,winpos,winsize

let _p = expand('~/.vim/session')
if !isdirectory(_p)
    call mkdir(_p, 'p')
endif



fun! s:save_session(ses)
    if a:ses
        exe 'Obsession ~/.vim/session/' . a:ses
    else
        Obsession ~/.vim/session/default.vim
    endif
endfun

fun! s:load_session(ses)
    if a:ses
        exe 'so ~/.vim/session/' . a:ses
    else
        so ~/.vim/session/default.vim
    endif
endfun



fun! s:restart()
    Save
    call system('gvim -c "Load"')
    quitall
endfun

com! -nargs=? Save call s:save_session(<q-args>)
com! -nargs=? Load call s:load_session(<q-args>)
com! -nargs=0 Restart :call s:restart()
