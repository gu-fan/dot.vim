aug au_basic
  au!
    au BufEnter,BufNew,BufReadPost * silent! lcd %:p:h:gs/ /\\ /
    au BufEnter,BufNew,BufReadPost * silent! exec 'setl sua+=.'.expand('<afile>:e')

    " to the line when file last opened
    au BufReadPost * if line("'\"") && line("'\"") <= line("$") | exe  "normal! g`\"" | endif
    au CompleteDone * if pumvisible() == 0 | pclose | endif
    autocmd QuickFixCmdPost * botright copen 8

aug END

aug au_GuiEnter "{{{
    au!
    au GuiEnter * set t_vb=
aug END
