let g:mapleader=' '
let g:maplocalleader=' '

nmap <leader>vv :e ~/.dot.vim/index.vim<CR>
nmap <leader>bb :e ~/.zshrc<CR>

" with input method "{{{ 1
se imd
se ims=1
se noimc
" se imi=2

nmap ： :


"{{{ 1
cmap w!! w !sudo tee % >/dev/null<CR>:e!<CR><CR>
noremap <C-CR> gJ

nor <Leader>li :setl list! list?<CR>

set nonu nornu
nor <leader>nn :setl <c-r>=&rnu?'nornu':&nu?'nonu':'rnu'<CR><CR>
nno <silent><leader>dd :exec &diff ? 'diffoff' : 'diffthis'<CR>

" Clear screen
nno   <silent>   <c-l>   :let @/=''\|redraw!<CR>

if &term == "xterm"
    nno <c-r>  <c-v>
endif

" Moving
nno   H   h
nno   L   l
nno   J   j
nno   K   k
nno   j   gj
nno   k   gk

vno   j  gj
vno   k  gk

nno   <leader>   <Nop>
vno   <leader>   <Nop>
nno   s          <Nop>
nno   S          <Nop>
nno   Q          <Nop>
" similar with D
" nno   yy         "*yy
nno   Y          "*y$
" nno   p          "*p
nno   cc        <nop>
" nno   dd         "*dd
" nno   D          "*D
" vno   y          "*y
" vno   d          "*d
" vno   x          "*x

nno   >          >>
nno   <          <<
vno   >          >gv
vno   <          <gv

" repeat on every line
vno   .          :normal .<CR>
nor <rightmouse><leftmouse> <c-o>
nor <rightmouse><rightmouse> <c-o>
nor <rightrelease><leftrelease> <c-o>
ino <rightrelease><leftrelease> <c-o><c-o>



" Window
nno <silent><C-W>1 :resize<cr>
nno <silent><C-W>2 :vert resize<cr>
nno <silent><C-W>3 <C-W>=


nno <silent><A-1>  :if &go=~#'m' \| set go-=m \| else \| set go+=m \| endif<CR>
nno <silent><A-2>  :if &go=~#'e' \| set go-=e \| else \| set go+=e \| endif<CR>

nno <C-W>n <C-W>w
nno <C-W>N <C-W>n

" smarter opening files. 
" TODO
" should replace with click.vim
fun! s:edit_file(ask)
    let file = expand('<cfile>')
    let ptn ='\v(%(file|https=|ftp|gopher)://|%(mailto|news):)([0-9a-zA-Z#&?._-~/]*)'
    let links = matchlist(file,ptn)
    if !empty(links)
        if links[1] =~ 'file'
            let file = links[2]
        else
            sil! exe "!firefox ". links[2]
        endif
        return
    endif
    let file = expand(file)
    if filereadable(file) || isdirectory(file)
        exe "edit ".file
        return
    elseif a:ask==1 && input("file: ".file." not exists, continue?(Y/n)") =~?"y"
        exe "edit ".file
        return
    endif

    " find the file match with <cfile>.ext
    if file !~ '^\s*$'
        let files = split(glob(expand('%:p:h')."/".file.".*"),'\n')
        if !empty(files)
            exe "edit ".files[0]
            for f in files[1:]
                exe "split ".f
            endfor
            return
        endif
    endif
endfun 
nno <silent><C-W>v :vsp\|call <SID>edit_file(0)<CR>
nno <silent><C-W>s :sp\|call <SID>edit_file(0)<CR>
nno <silent><C-W><C-V> :on\|vsp\|call <SID>edit_file(0)<CR>
nno <silent><C-W><C-S> :sp\|call <SID>edit_file(0)<CR>
nno <silent><C-W><C-T> :tab sp\|call <SID>edit_file(0)<CR>
nno <silent><C-W><C-F> :sp\|call <SID>edit_file(1)<CR> 
" Save
nnoremap <c-s> :w<CR>

" syntax dev tool (vim dev) 
nma <silent><leader>1ss :call <SID>synstack()<CR>
function! s:synstack() 
    if exists("*synstack")
        for id in synstack(line("."), col("."))
            echon " ".synIDattr(id, "name")
            exe "echoh ".synIDattr(id, "name")
            echon "[".synIDattr(synIDtrans(id), "name")."]"
            echoh None
        endfor
    endif
endfunc 
function! s:editstack()
    if exists("*synstack")
        let id = synstack(line("."), col("."))[0]
            split
            exec "edit $VIMRUNTIME/syntax/" .b:current_syntax. ".vim"
            call search(synIDattr(id, "name"),'c')
            update
            echoe " ".synIDattr(id, "name")
            exe "echoh ".synIDattr(id, "name")
            echon "[".synIDattr(synIDtrans(id), "name")."]"
            echoh None
    endif
endfunc

nma <silent><leader>1sn :exec "edit $VIMRUNTIME/syntax/" .b:current_syntax. ".vim"<CR>
nma <silent><leader>1se :call <SID>editstack()<CR>
