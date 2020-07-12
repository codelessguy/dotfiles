" Reload :so $MYVIMRC

" Plugins {{{
call plug#begin()
Plug 'prabirshrestha/async.vim'
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/vim-lsp'
Plug 'prabirshrestha/asyncomplete-lsp.vim'
Plug 'tikhomirov/vim-glsl'
call plug#end()
" }}}

" General {{{
let mapleader = ','
set encoding=utf-8
set clipboard=unnamedplus " Copy from the X clipboard
autocmd BufWritePre * %s/\s\+$//e " Remove trailing whitespace on save
" }}}

" Backup {{{
set noswapfile
" }}}

" Line number {{{
set ruler               " Show the line and column numbers of the cursor.
set number              " Show the line numbers on the left side.
set relativenumber " turn relative line numbers on
set rnu
" }}}

" Indentation {{{
" see indentation :set list  and to disable :set nolist
set colorcolumn=80      " Line showing limit of 80 characters per line
set ai "Auto indent
set si "Smart indent
set wrap "Wrap lines
set noexpandtab   " Use tab for indentation
set tabstop=4
set shiftwidth=4          " Indentation amount for < and > commands.
" }}}

" Theme {{{
syntax on " Enable syntax highlighting
colorscheme desert
" }}}

" Split {{{
" More natural splits
set splitbelow          " Horizontal split below current.
set splitright          " Vertical split to right of current.
" }}}

" Search {{{
set ignorecase          " Make searching case insensitive
set smartcase           " ... unless the query has capital letters.
" Use <C-L> to clear the highlighting of :set hlsearch.
if maparg('<C-L>', 'n') ==# ''
  nnoremap <silent> <C-L> :nohlsearch<CR><C-L>
endif
" Search and Replace
nmap <Leader>s :%s///g<Left><Left><Left>
" }}}

" Performance {{{
set lazyredraw " Don’t update screen during macro and script execution.
" }}}

" C {{{
" Disabled because report an error on C designated initializers
let c_no_curly_error=1
" let c_no_bracket_error=1
" }}}

" vim-lsp {{{
if executable('clangd')
    au User lsp_setup call lsp#register_server({
        \ 'name': 'clangd',
        \ 'cmd': {server_info->['clangd', '-background-index']},
        \ 'whitelist': ['c', 'cpp', 'objc', 'objcpp'],
        \ })
endif
if executable('cclsaaa')
   au User lsp_setup call lsp#register_server({
      \ 'name': 'ccls',
      \ 'cmd': {server_info->['ccls']},
      \ 'root_uri': {server_info->lsp#utils#path_to_uri(lsp#utils#find_nearest_parent_file_directory(lsp#utils#get_buffer_path(), 'compile_commands.json'))},
      \ 'initialization_options': {},
      \ 'whitelist': ['c', 'cpp', 'objc', 'objcpp', 'cc'],
      \ })
endif

nmap <F1> :LspDefinition<CR>
nmap <F2> :LspDeclaration<CR>
nmap <F3> :LspRename<CR>
" }}}

" asyncomplete {{{
let g:asyncomplete_auto_popup = 1
" Tab completion
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <cr>    pumvisible() ? "\<C-y>" : "\<cr>"

" Force refresh completion
imap <c-space> <Plug>(asyncomplete_force_refresh)
" }}}

" Fold {{{
set foldmethod=syntax
set foldlevel=99
" }}}

" Move around {{{
noremap <C-j> 5j
noremap <C-k> 5k
" }}}

" vim:foldmethod=marker:foldlevel=0
