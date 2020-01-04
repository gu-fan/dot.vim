let search = {}

fun! search.escape(ptn, mode)
    if a:mode == "search"
        return escape(a:ptn, '')
    elseif a:mode == "edit"
        return escape(a:ptn, '*[]/~.$\')
    elseif a:mode == "replace"
        return escape(a:ptn, '&')
    endif
endfun
fun! search.getvis()
    normal gv"yy
    return @y
endfun

fun! search.generate(word,mode) dict "{{{
    let rs = a:word
    if a:mode =~ "b"
        let ss = "\\<". self.escape(a:word,"search") ."\\>"
    else
        let ss = self.escape(a:word,"search")
    endif
    return "s/".ss."/".a:word. "/gc" 
endfunction "}}}



fun! search.test2() dict
    echom 1111
    return 1111
endfun


Export search
" call export.at(s:search, expand("<sfile>:p"))
