source $VIMRUNTIME/mswin.vim


" Undo/Redo, add 'zv' to view redo/undo line
nor <C-Z>       uzv
ino <C-Z>       <C-O>u<C-O>zv
vno <C-Z>       <Nop>

nor <C-Y>       <C-R>zv
ino <C-Y>       <C-O><C-R><C-O>zv
vno <C-Y>       <Nop>

" CTRL-A is Select all: 
" change select mode to visual mode,
" except insert mode
noremap <C-A> ggVG
inoremap <C-A> <C-O>gg<C-O>gH<C-O>G
cnoremap <C-A> <C-C>ggVG
onoremap <C-A> <C-C>ggVG
snoremap <C-A> <C-C>ggVG
xnoremap <C-A> <C-C>ggVG

