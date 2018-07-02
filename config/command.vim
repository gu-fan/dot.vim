
com! Copy let @+ = expand('%:p')|echo 'PATH:'.@+
com! Trail call Trim()
com! Trim call Trim()

cabbrev ss so %
cabbrev E e
cabbrev dir Dir
cabbrev save Save
cabbrev load Load

function! Trim()
    sil! %s#\s\+$##g
    w!
endfun
