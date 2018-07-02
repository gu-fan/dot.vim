Plug 'Shougo/deol.nvim'

set shell=/bin/zsh
com! -nargs=0  Shell Deol
com! -nargs=0  Scd DeolCd %:p:h
com! -nargs=0  Sedit DeolEdit
