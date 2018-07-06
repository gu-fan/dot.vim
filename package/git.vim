Plug 'tpope/vim-fugitive'

nnoremap <Leader>gp :Srun git push<CR>
nnoremap <Leader>gP :Srun git pull<CR>
nnoremap <leader>gc :Gcommit -a -v<CR>
nnoremap <leader>gs :Gstatus<CR>
nnoremap <leader>gb :Gblame<CR>

Plug 'airblade/vim-gitgutter'

Plug 'Shougo/echodoc'
" Plug 'skywind3000/asyncrun.vim'
" command! -bang -nargs=* -complete=file Make AsyncRun -program=make @ <args>

" Plug 'chemzqm/vim-easygit'
" Plug 'chemzqm/denite-git'

" Plug 'kopischke/vim-stay'

