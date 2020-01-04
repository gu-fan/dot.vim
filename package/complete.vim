
Plug 'Shougo/neocomplcache'
Plug 'Shougo/neosnippet'
Plug 'Shougo/neosnippet-snippets'

" Neocomplcache "{{{2
nno <leader>nt :NeoComplCacheToggle<CR>
nno <leader>nb :NeoComplCacheCachingBuffer<CR>
let g:acp_enableAtStartup                      = 0
let g:neocomplcache_enable_at_startup          = 1
let g:neocomplcache_enable_smart_case          = 1
let g:neocomplcache_enable_camel_case_completion = 1
let g:neocomplcache_enable_ignore_case         = 0
" Use underbar completion.
let g:neocomplcache_enable_underbar_completion = 1
let g:neocomplcache_min_syntax_length          = 2
let g:neocomplcache_lock_buffer_name_pattern   = '\*ku\*'

" Define dictionary.
let g:neocomplcache_dictionary_filetype_lists = {
            \ 'default' : '',
            \ 'vimshell' : $HOME.'/.vimshell_hist',
            \ 'scheme' : $HOME.'/.gosh_completions'
            \ }
" Define keyword.
if !exists('g:neocomplcache_keyword_patterns')
    let g:neocomplcache_keyword_patterns = {}
endif
let g:neocomplcache_keyword_patterns['default'] = '\h\w*'

" let g:neocomplcache_disable_caching_file_path_pattern="fuf"
" let g:neocomplcache_quick_match_patterns={'default':'`'}
" let g:neocomplcache_quick_match_table = {
"             \'1' : 0, '2' : 1, '3' : 2, '4' : 3, '5' : 4, '6' : 5, '7' : 6, '8' : 7, '9' : 8, '0' : 9,
"             \}

if exists("*neocomplcache#smart_close_popup")
    ino <expr><C-h>   neocomplcache#smart_close_popup()."\<left>"
    ino <expr><C-l>   neocomplcache#smart_close_popup()."\<right>"
    ino <expr><Space> neocomplcache#smart_close_popup()."\<Space>"
    ino <expr><CR>    neocomplcache#smart_close_popup()."\<CR>"
    ino <expr><BS>    neocomplcache#smart_close_popup()."\<BS>"
    ino <expr><C-y>   neocomplcache#close_popup()
endif

"{{{ omni comp
aug neocomp_omni_compl "{{{
    au! neocomp_omni_compl
    " Enable omni completion.
    autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
    autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
    autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
    autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
    autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
aug END "}}}
" Enable heavy omni completion.
if !exists('g:neocomplcache_omni_patterns')
    let g:neocomplcache_omni_patterns = {}
endif
let g:neocomplcache_omni_patterns.ruby = '[^. *\t]\.\w*\|\h\w*::'
"autocmd FileType ruby setlocal omnifunc=rubycomplete#Complete
let g:neocomplcache_omni_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
let g:neocomplcache_omni_patterns.c = '\%(\.\|->\)\h\w*'
let g:neocomplcache_omni_patterns.cpp = '\h\w*\%(\.\|->\)\h\w*\|\h\w*::'
"}}}



" if has('nvim')
"   Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
" else
"   Plug 'Shougo/deoplete.nvim'
"   Plug 'roxma/nvim-yarp'
"   Plug 'roxma/vim-hug-neovim-rpc'
" endif
"
" let g:deoplete#enable_at_startup = 1
" "
" "
"
" " deoplete options
" let g:deoplete#enable_smart_case = 1
"
" " disable autocomplete by default
" let b:deoplete_disable_auto_complete=1 
" let g:deoplete_disable_auto_complete=1
" call deoplete#custom#buffer_option('auto_complete', v:false)
"
" if !exists('g:deoplete#omni#input_patterns')
"     let g:deoplete#omni#input_patterns = {}
" endif
"
" " Disable the candidates in Comment/String syntaxes.
" call deoplete#custom#source('_',
"             \ 'disabled_syntaxes', ['Comment', 'String'])
"
" autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif
"
" " set sources
" let g:deoplete#sources = {}
" let g:deoplete#sources.cpp = ['LanguageClient']
" let g:deoplete#sources.python = ['LanguageClient']
" let g:deoplete#sources.python3 = ['LanguageClient']
" let g:deoplete#sources.rust = ['LanguageClient']
" let g:deoplete#sources.c = ['LanguageClient']
" let g:deoplete#sources.vim = ['vim']
" "
" Plug 'carlitux/deoplete-ternjs', { 'do': 'npm install -g tern' }
"
" let g:deoplete#sources#ternjs#tern_bin = '/usr/local/bin/tern'
" let g:deoplete#sources#ternjs#timeout = 1
"
" " Whether to include the types of the completions in the result data. Default: 0
" let g:deoplete#sources#ternjs#types = 0
"
" " Whether to include the distance (in scopes for variables, in prototypes for 
" " properties) between the completions and the origin position in the result 
" " data. Default: 0
" let g:deoplete#sources#ternjs#depths = 1
"
" " Whether to include documentation strings (if found) in the result data.
" " Default: 0
" let g:deoplete#sources#ternjs#docs = 0
"
" " When on, only completions that match the current word at the given point will
" " be returned. Turn this off to get all results, so that you can filter on the 
" " client side. Default: 1
" let g:deoplete#sources#ternjs#filter = 0
"
" " Whether to use a case-insensitive compare between the current word and 
" " potential completions. Default 0
" let g:deoplete#sources#ternjs#case_insensitive = 1
"
" " When completing a property and no completions are found, Tern will use some 
" " heuristics to try and return some properties anyway. Set this to 0 to 
" " turn that off. Default: 1
" let g:deoplete#sources#ternjs#guess = 0
"
" " Determines whether the result set will be sorted. Default: 1
" let g:deoplete#sources#ternjs#sort = 0
"
" " When disabled, only the text before the given position is considered part of 
" " the word. When enabled (the default), the whole variable name that the cursor
" " is on will be included. Default: 1
" let g:deoplete#sources#ternjs#expand_word_forward = 0
"
" " Whether to ignore the properties of Object.prototype unless they have been 
" " spelled out by at least two characters. Default: 1
" let g:deoplete#sources#ternjs#omit_object_prototype = 0
"
" " Whether to include JavaScript keywords when completing something that is not 
" " a property. Default: 0
" let g:deoplete#sources#ternjs#include_keywords = 1
"
" " If completions should be returned when inside a literal. Default: 1
" let g:deoplete#sources#ternjs#in_literal = 0
"
"
" "Add extra filetypes
" let g:deoplete#sources#ternjs#filetypes = [
"                 \ 'jsx',
"                 \ 'javascript.jsx',
"                 \ 'vue',
"                 \ '...'
"                 \ ]
"


" neocompl cache snippets_complete
" nmap <c-k> a<c-k><esc>
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)

" ino <expr>.   pumvisible() ? "." : "."
ino <expr><TAB>   pumvisible() ? "\<C-n>" : "\<TAB>"
ino <expr><s-TAB> pumvisible() ? "\<C-p>" : "\<s-TAB>"
" SuperTab like snippets behavior.
" imap <expr><TAB> neosnippet#expandable_or_jumpable() ?
" \ "\<Plug>(neosnippet_expand_or_jump)"
" \: pumvisible() ? "\<C-n>" : "\<TAB>"
" smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
" \ "\<Plug>(neosnippet_expand_or_jump)"
" \: "\<TAB>"

" For snippet_complete marker.
if has('conceal')
    set conceallevel=0 concealcursor=i
endif
let g:neosnippet#snippets_directory = "~/Dropbox/vim/my_snips/snippets_complete/"

map <leader>pe :sp\|NeoSnippetEdit<cr>
map <leader>pr :sp\|NeoSnippetSource<cr>
map <leader>p_ :sp\|e ~/Dropbox/vim/my_snips/snippets_complete/_.snip <cr>

" Deprecated, not good as neosnippet
" Plug 'vim-scripts/UltiSnips'
" Plug 'tomtom/tcomment_vim'
" let g:tcommentMapLeaderOp1 = '<leader>c'
" nnoremap <c-/> :TComment<cr>
" let g:tcommentGuessFileType = 0
" let g:tcommentGuessFileType_vue = 'html'
"
Plug 'tpope/vim-commentary'

nno <leader>cc :Commentary<CR>
vno <leader>cc :Commentary<CR>
" vno <leader>c :Commentary<CR>
vno <leader>c <Nop>

Plug 'tpope/vim-surround'
" Plug 'tpope/vim-repeat'
" Plug 'tpope/vim-abolish'
