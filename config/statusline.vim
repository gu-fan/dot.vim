" from https://github.com/chemzqm/vimrc
let s:job_status = {}

function! MyStatusSyntaxItem()
  return synIDattr(synID(line("."),col("."),1),"name")
endfunction

function! MyStatusLine()
  let errorMsg = has('nvim') ? "%= %3*%{MyStatusLocError()}%* %=" : ""
  return s:GetPaste()
        \. "%4*%{MyStatusGit()}%*"
        \. "%5*%{MyStatusGitChanges()}%*"
        \. " %{MyStatusTsc()} %{Fname(g:actual_curbuf)} %{MyStatusRunningFrame()} %{MyStatusModifySymbol()}"
        \. " %{MyStatusReadonly()} "
        \. errorMsg
        \. "%="
        \. MyStatusFile()
        \. " %-{&ft} %l,%c %P "
"%{&fenc}
endfunction


" XXX!
" Seems you can only get the CURRENT buffer (editing one)
" but don't know if it's !ACTIVE / !INACTIVE while render statusline
"
" the g:actual_curbuf not work
" so even a %f  or %n can not be get
"
"
" NOTE: use %{} to get the exec buffer context
fun! Echo()
    return bufnr('%')
endfun
" show :p:.
function! Fname(cur) abort

  " return bufname(a:buf)
  let fname = bufname(a:cur)
  " return bufnr(a:cur)
  " return fname
  if a:cur == bufnr('%')
    " return ' yes '
    " return fnamemodify(fname, ':p:.')
    return expand('%:p:h:t') . '/' . expand('%:t')
  else
    return expand('%:.')
    " return ' not '
  endif
  " return expand('%:p:h')
endfunction

fun! GetGitDir()
    let full = expand('%:p:h')

    let p_len = len(split(full, '/'))
    let parents = map(range(p_len), 'fnamemodify(full, repeat(":h" ,v:val))')
    call map(parents, 'v:val."/.git"')
    call filter(parents, 'isdirectory(v:val)')

	if len(parents) > 0
		let main = fnamemodify(parents[0], ':h:t')
        return ' '. main. ' '
    else 
        return ''
    endif
    
endfun




fun! MyStatusFile()
    " return '%{Echo()}'
    " return '%n %{Echo()}'
    " return bufnr('%')
    " return exists("g:actual_curbuf") ? g:actual_curbuf : 'NONE'
    return '%#MyStatusLineTitle#%{GetGitDir()}%*'


    let full = expand('%:p:h')
    let name = expand('%:t')

    let p_len = len(split(full, '/'))
    let parents = map(range(p_len), 'fnamemodify(full, repeat(":h" ,v:val))')
    call map(parents, 'v:val."/.git"')
    call filter(parents, 'isdirectory(v:val)')

	if len(parents) > 0
		let main = fnamemodify(parents[0], ':h:t')
		let full_fix = substitute(full, main, '#####','')
		let trim = fnamemodify(full_fix, ':gs?\([^/#]\)[^/#]*?\1?')
		let trim_rev = substitute(trim, '#####', '%#StatusLine#'.main.'%#StatusLineNC#','')
		return "%#StatusLineNC#"  . trim_rev .'/%*'  . '%{Echo(%n)}'
	else
        return ''
	endif
	


    " return "%#StatusLineNC#"  . trim.'/%*' . name
    
endfun

function! s:IsTempFile()
  if !empty(&buftype) | return 1 | endif
  if &filetype ==# 'gitcommit' | return 1 | endif
  if expand('%:p') =~# '^/tmp' | return 1 | endif
endfunction

function! s:GetPaste()
  if !&paste | return '' |endif
  return "%#MyStatusPaste# paste %*"
endfunction

function! MyStatusReadonly()
  if !&readonly | return '' |endif
  return "  "
endfunction

function! MyStatusRunningFrame()
  let s = get(g:, 'tslint_frame', '')
  return s
endfunction

function! MyStatusTsc()
  if s:IsTempFile() | return '' | endif
  let s = get(g:, 'tsc_status', '')
  if s ==? 'init'
    return ''
  elseif s ==? 'running'
    return '🌴'
  elseif s ==? 'stopped'
    return '⚪️'
  elseif s ==? 'error'
    return '🔴'
  endif
  return ''
endfunction

function! MyStatusModifySymbol()
  return &modified ? '⚡' : ''
endfunction

function! MyStatusGitChanges() abort
  if s:IsTempFile() | return '' | endif
  let gutter = get(b:, 'gitgutter', {})
  if empty(gutter) | return '' | endif
  let summary = get(gutter, 'summary', [])
  if empty(summary) | return '' | endif
  if summary[0] == 0 && summary[1] == 0 && summary[2] == 0
    return ''
  endif
  return '  +'.summary[0].' ~'.summary[1].' -'.summary[2].' '
endfunction

function! MyStatusGit(...) abort
  if s:IsTempFile() | return '' | endif
  let reload = get(a:, 1, 0) == 1
  if exists('b:git_branch') && !reload | return b:git_branch | endif
  if !exists('*FugitiveExtractGitDir') | return '' | endif
  if s:IsTempFile() | return '' | endif
  " only support neovim
  if !exists('*jobstart') | return '' | endif
  let roots = values(s:job_status)
  let dir = get(b:, 'git_dir', FugitiveExtractGitDir(resolve(expand('%:p'))))
  if empty(dir) | return '' | endif
  let b:git_dir = dir
  let root = fnamemodify(dir, ':h')
  if index(roots, root) >= 0 | return '' | endif
  let nr = bufnr('%')
  let job_id = jobstart('git-status', {
    \ 'cwd': root,
    \ 'stdout_buffered': v:true,
    \ 'stderr_buffered': v:true,
    \ 'on_exit': function('s:JobHandler')
    \})
  if job_id == 0 || job_id == -1 | return '' | endif
  let s:job_status[job_id] = root
  return ''
endfunction

function! s:JobHandler(job_id, data, event) dict
  if !has_key(s:job_status, a:job_id) | return | endif
  if v:dying | return | endif
  let output = join(self.stdout)
  if !empty(output)
    call s:SetGitStatus(self.cwd, ' '.output.' ')
  else
    let errs = join(self.stderr)
    if !empty(errs) | echoerr errs | endif
  endif
  call remove(s:job_status, a:job_id)
endfunction

function! s:SetGitStatus(root, str)
  let buf_list = filter(range(1, bufnr('$')), 'bufexists(v:val)')
  for nr in buf_list
    let path = fnamemodify(bufname(nr), ':p')
    if match(path, a:root) >= 0
      call setbufvar(nr, 'git_branch', a:str)
    endif
  endfor
  redraws!
endfunction

function! SetStatusLine(file)
  if &previewwindow | return | endif
  if s:IsTempFile() | return | endif
  call MyStatusGit(1)
  setl statusline=%!MyStatusLine()
  call s:highlight()
endfunction

function! s:PrintError(msg)
  echohl Error | echon a:msg | echohl None
endfunction

function! s:highlight()
  hi User3         guifg=#e03131 guibg=#111111    gui=none
  hi MyStatusPaste guifg=#F8F8F0 guibg=#FF5F00 gui=none
  hi MyStatusPaste ctermfg=202   ctermbg=16    cterm=none
  hi User4 guifg=#f8f8ff guibg=#000000
  hi User5 guifg=#f8f9fa guibg=#343a40

    " GET Current Color
    try
        let tabbgcolor=synIDattr(hlID('Tablinefill'), 'bg#')
        let tabselbgcolor=synIDattr(hlID('TablineSel'), 'bg#')
        let statbgcolor=synIDattr(hlID('StatusLine'), 'bg#')
        let statfgcolor=synIDattr(hlID('StatusLine'), 'bg#')
        "
        exe "hi MyTablineTitle guifg=#99A8CC guibg=".tabbgcolor." gui=none"
        exe "hi MyTablineSeLTitle guifg=#99A8CC guibg=".tabselbgcolor." gui=none"
        exe "hi MyStatusLineTitle guifg=#99A8CC guibg=".tabbgcolor." gui=none"
        
    catch /E254/
        
    endtry
endfunction

function! MyStatusLocError()
  let list = filter(getloclist('%'), 'v:val["type"] ==# "E"')
  if len(list)
    return ' ' . string(list[0].lnum) . ' ' . list[0].text
  else
    return ''
  endif
endfunction

augroup statusline
  autocmd!
  autocmd User GitGutter call SetStatusLine(expand('%'))
  autocmd BufWinEnter,ShellCmdPost,BufWritePost * call SetStatusLine(expand('%'))
  autocmd FileChangedShellPost,ColorScheme * call SetStatusLine(expand('%'))
  autocmd FileReadPre,ShellCmdPost,FileWritePost * call SetStatusLine(expand('%'))
augroup end


set tabline=%!MyTabLine()  " custom tab pages line
function! MyTabLine()
        let s = '' " complete tabline goes here
        " loop through each tab page
        for t in range(tabpagenr('$'))
                " set highlight
                if t + 1 == tabpagenr()
                        let s .= '%#TabLineSel#'
                else
                        let s .= '%#TabLineFill#'
                endif
                " set the tab page number (for mouse clicks)
                let s .= '%' . (t + 1) . 'T'
                if t + 1 == tabpagenr()
                    let s .= '%#MyTablineSelTitle# '
                else
                    let s .= '%#MyTablineTitle# '
                endif
                " set page number string
                let s .= t + 1 . ''
                let full = fnamemodify(bufname(tabpagebuflist(t + 1)[0]), ':p:h')
                let git_full = GetGitDirFull(full)
                let s .= git_full != '' ? ' '. git_full. '' : ''
                let s .=  ' %*'
                " get buffer names and statuses
                let n = ''      "temp string for buffer names while we loop and check buftype
                let m = 0       " &modified counter
                let bc = len(tabpagebuflist(t + 1))     "counter to avoid last ' '
                " loop through each buffer in a tab
                for b in tabpagebuflist(t + 1)
                        " buffer types: quickfix gets a [Q], help gets [H]{base fname}
                        " others get 1dir/2dir/3dir/fname shortened to 1/2/3/fname
                        if getbufvar( b, "&buftype" ) == 'help'
                                " let n .= '[H]' . fnamemodify( bufname(b), ':t:s/.txt$//' )
                                let n .= '[H]'
                        elseif getbufvar( b, "&buftype" ) == 'quickfix'
                                let n .= '[Q]'
                        else
                                " let n .= pathshorten(bufname(b))
                        endif
                        " check and ++ tab's &modified count
                        if getbufvar( b, "&modified" )
                                let m += 1
                        endif
                        " no final ' ' added...formatting looks better done later
                        if bc > 1
                                let n .= ' '
                        endif
                        let bc -= 1
                endfor
                let p = pathshorten(bufname(tabpagebuflist(t + 1)[0]))

                
                let _l = split(p, '/')
                if len(_l) > 4
                    let _l = _l[-4:]
                endif
                let k = join(_l,'/')

                let n .= ' ' .k

                " add modified label [n+] where n pages in tab are modified
                "
                let total = len(tabpagebuflist(t + 1))
                if m > 0
                        let n .= '[' .total . ':' .m . '+]'
                else
                        if total > 1
                            let n .= ' ['.total.']'
                        endif
                endif
                " select the highlighting for the buffer names
                " my default highlighting only underlines the active tab
                " buffer names.
                if t + 1 == tabpagenr()
                        let s .= '%#TabLineSel#'
                else
                        " let s .= '%#TabLine#'
                endif
                
                " add buffer names
                if n == ''
                        let s.= '[New]'
                else
                        let s .= n
                endif
                " switch to no underlining and add final space to buffer list
                let s .= ' '
        endfor
        " after the last tab fill with TabLineFill and reset tab page nr
        let s .= '%#TabLineFill#%T'
        " right-align the label to close the current tab page
        if tabpagenr('$') > 1
                let s .= '%=%#TabLineFill#%999XX'
        endif
        return s
endfunction

fun! GetGitDirFull(full)
    let full = a:full

    let p_len = len(split(full, '/'))
    let parents = map(range(p_len), 'fnamemodify(full, repeat(":h" ,v:val))')
    call map(parents, 'v:val."/.git"')
    call filter(parents, 'isdirectory(v:val)')

	if len(parents) > 0
		let main = fnamemodify(parents[0], ':h:t')
        return main
    else 
        return ''
    endif
    
endfun

" set tabline=%!MyTabLine()
