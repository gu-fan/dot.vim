Plug 'tpope/vim-fugitive'

nnoremap <Leader>gp :AsyncRun git push<CR>
nnoremap <Leader>gP :AsyncRun git pull<CR>
nnoremap <Leader>gc :Gcommit -a<CR>
nnoremap <Leader>gs :Gstatus<CR>
nnoremap <Leader>gb :Gblame<CR>
nnoremap <Leader>gca :Gcommit -a<CR>

Plug 'airblade/vim-gitgutter'
Plug 'skywind3000/asyncrun.vim'
command! -bang -nargs=* -complete=file Make AsyncRun -program=make @ <args>

Plug 'chemzqm/vim-easygit'
Plug 'chemzqm/denite-git'

Plug 'Shougo/echodoc'
Plug 'kopischke/vim-stay'

