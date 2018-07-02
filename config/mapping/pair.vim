" Pairs "{{{
" vno q< <esc>`>a><esc>`<i<<esc>lv`>l
" vno q{ <esc>`>a}<esc>`<i{<esc>lv`>l
" vno q( <esc>`>a)<esc>`<i(<esc>lv`>l
" vno q" <esc>`>a"<esc>`<i"<esc>lv`>l
" vno q' <esc>`>a'<esc>`<i'<esc>lv`>l
" vno q* <esc>`>a*<esc>`<i*<esc>lv`>l
" vno q_ <esc>`>a_<esc>`<i_<esc>lv`>l

" NOTE:
" The ino is disabled when 'paste' optin is on.
function! s:init_pair()

    let pair_list = [ ['{','}'], ['[',']'], ['(',')'], ['<','>'],
                    \ ['"','"'], ["'","'"],
                    \ ['｛','｝'], ['［','］'], ['（','）'], ['＜','＞'],
                    \ ['＂','＂'], ["＇","＇"],["`","`"]
                    \ ]

    for [s,e] in pair_list

        " Input style 1: 1to1 & 2to2
        exec 'ino '.s.  ' '.s
        exec 'ino '.s.s.' '.s.e.'<left>'
        exec 'cno '.s.s.' '.s.e.'<left>'
        exec 'cno '.s.  ' '.s
        
        " " Input style 2: 1to2 & 2to1
        " " easier to inpu a single s , but often mistake for two quote
        " exec 'ino '.s.' '.s.e.'<left>'
        " exec 'ino '.s.'<esc> '.s
        " exec 'ino '.s.s.' '.s
        " exec 'cno '.s.' '.s.e.'<left>'
        " exec 'cno '.s.s.' '.s
        " exec 'cno '.s.'<esc> '.s

        exec 'ino '.e.'<c-a> '.e.'<esc>m`^i'.s.'<esc>``a'
        exec 'ino '.e.'<c-b> '.e.'<esc>m`bi'.s.'<esc>``a'
        exec 'cno '.e.'<c-a> '.e.'<home>'.s
        exec 'cno '.e.'<c-b> '.e.'<s-left>'.s
        exec 'ino '.s.'<c-e> '.s.'<esc>m`$a'.e.'<esc>``a'
        exec 'ino '.s.'<c-w> '.s.'<esc>m`ea'.e.'<esc>``a'
        exec 'cno '.s.'<c-e> '.s.'<end>'.e
        exec 'cno '.s.'<c-w> '.s.'<s-right>'.e

        exec 'vno q'.s .' <esc>`>a'.e.'<esc>`<i'.s.'<esc>lv`>l'

        if s != e
            exec "ino ".s.e." ".s.e
        endif

        unlet s
        unlet e
    endfor
endfunction


call <SID>init_pair()

ino {<CR>  {<CR>}<Esc>O<tab>
ino {<c-e> {<c-o>mz<end><cr>}<c-o>`z<cr><tab>
