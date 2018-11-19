call plug#begin('~/.local/share/nvim/plugged')
" Plugins {{{
" ## Before to install:
" pip3 install neovim
" npm install -g neovim typescript

" For async completion
Plug 'Shougo/deoplete.nvim'
" For Denite features
Plug 'Shougo/denite.nvim'

" Go
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries', 'for': 'go' }
Plug 'zchee/deoplete-go', { 'do': 'make', 'for': 'go' }

" Typescript
Plug 'HerringtonDarkholme/yats.vim', { 'for': 'typescript.tsx' }
Plug 'mhartington/nvim-typescript', {'do': './install.sh', 'for': 'typescript.tsx' }

Plug 'neomake/neomake'

" Buffers
Plug 'Asheq/close-buffers.vim'

" Files
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }

" File search
Plug '~/.fzf'
Plug 'junegunn/fzf.vim'

" Theme
Plug 'morhetz/gruvbox'
Plug 'NLKNguyen/papercolor-theme'
Plug 'junegunn/seoul256.vim'
Plug 'dracula/vim'

" Bar
Plug 'vim-airline/vim-airline'
"Plug 'vim-airline/vim-airline-themes' " Dracula already have the theme

" Show color
Plug 'lilydjwg/colorizer'

" Close bracket automatically
Plug 'Raimondi/delimitMate'

" Auto comment code
Plug 'scrooloose/nerdcommenter'

" .Editor config
Plug 'editorconfig/editorconfig-vim'
" }}}
call plug#end()

" RELOAD VIM !!!
" :so $MYVIMRC
" BASE CONFIG: http://nerditya.com/code/guide-to-neovim/ {{{
let mapleader = ','

set showcmd             " Show (partial) command in status line.
set showmatch           " Show matching brackets.
set showmode            " Show current mode.
set ruler               " Show the line and column numbers of the cursor.
set number              " Show the line numbers on the left side.
set formatoptions+=o    " Continue comment marker in new lines.
set textwidth=0         " Hard-wrap long lines as you type them.
set expandtab           " Insert spaces when TAB is pressed.
set tabstop=4           " Render TABs using this many spaces.
set shiftwidth=4        " Indentation amount for < and > commands.

set noerrorbells        " No beeps.
set modeline            " Enable modeline.
" set esckeys             " Cursor keys in insert mode.
set linespace=0         " Set line-spacing to minimum.
set nojoinspaces        " Prevents inserting two spaces after punctuation on a join (J)

" More natural splits
set splitbelow          " Horizontal split below current.
set splitright          " Vertical split to right of current.

if !&scrolloff
  set scrolloff=3       " Show next 3 lines while scrolling.
endif
if !&sidescrolloff
  set sidescrolloff=5   " Show next 5 columns while side-scrolling.
endif
set nostartofline       " Do not jump to first character with page commands.

" Tell Vim which characters to show for expanded TABs,
" trailing whitespace, and end-of-lines. VERY useful!
if &listchars ==# 'eol:$'
  set listchars=tab:>\ ,trail:-,extends:>,precedes:<,nbsp:+
endif
set list                " Show problematic characters.

" Also highlight all tabs and trailing whitespace characters.
highlight ExtraWhitespace ctermbg=darkgreen guibg=darkgreen
match ExtraWhitespace /\s\+$\|\t/

" Search
set ignorecase          " Make searching case insensitive
set smartcase           " ... unless the query has capital letters.
set gdefault            " Use 'g' flag by default with :s/foo/bar/.
set magic               " Use 'magic' patterns (extended regular expressions).

" Use <C-L> to clear the highlighting of :set hlsearch.
if maparg('<C-L>', 'n') ==# ''
  nnoremap <silent> <C-L> :nohlsearch<CR><C-L>
endif

" Search and Replace
nmap <Leader>s :%s//g<Left><Left>

set encoding=utf-8
set hidden " change buffer without saving

" Copy buffer into x clipboard 
set clipboard=unnamedplus
set noswapfile

" Enable folding
set foldmethod=indent
set foldlevel=99
" fold vimrc
set foldmethod=marker
" }}}

" Move around {{{
noremap <C-k> 5k
noremap <C-j> 5j

" Move between panes with "," + arrow keys
nmap <silent> <Leader><Up> :wincmd k<CR>
nmap <silent> <Leader><Down> :wincmd j<CR>
nmap <silent> <Leader><Left> :wincmd h<CR>
nmap <silent> <Leader><Right> :wincmd l<CR>
" Or use C-W h,j,k,l
" }}}

" Buffers {{{
noremap <Tab> :bnext<CR>
noremap <S-Tab> :bprevious<CR>
noremap <Leader>b :bdelete<CR>
nnoremap <silent> <C-q> :CloseHiddenBuffers<CR>
" CLose all buffers except the current one
" noremap <Leader>ab :%bd|e#|bd#<CR>
" bufdo bd   " close all buffers
" }}}

" Theme {{{
syntax on
set t_Co=256
" set background=light
colorscheme PaperColor
" colorscheme dracula
" colorscheme gruvbox
" colorscheme pyte
" colo seoul256-light
" }}}

" fzf {{{
nnoremap <silent> <Leader>f :Files<CR>
" https://github.com/junegunn/fzf/issues/128
" nmap <Leader>f :call fzf#run(fzf#wrap({'source': 'git ls-files --exclude-standard --others --cached'}))<CR>
nnoremap <silent> <Leader>g :Ag<CR>
" Mapping selecting mappings
nmap <leader><tab> <plug>(fzf-maps-n)
xmap <leader><tab> <plug>(fzf-maps-x)
omap <leader><tab> <plug>(fzf-maps-o)
" Insert mode completion
imap <c-x><c-k> <plug>(fzf-complete-word)
imap <c-x><c-f> <plug>(fzf-complete-path)
imap <c-x><c-j> <plug>(fzf-complete-file-ag)
imap <c-x><c-l> <plug>(fzf-complete-line)
"}}}

" NERDTree {{{
map <C-e> :NERDTreeToggle<CR>
map <leader>e :NERDTreeFind<CR>

let NERDTreeShowBookmarks=1
let NERDTreeIgnore=['\.py[cd]$', '\~$', '\.swo$', '\.swp$', '^\.git$', '^\.hg$', '^\.svn$', '\.bzr$']
let NERDTreeChDirMode=0
let NERDTreeQuitOnOpen=1
let NERDTreeMouseMode=2
let NERDTreeShowHidden=1
let NERDTreeKeepTreeInNewTab=1
let g:nerdtree_tabs_open_on_gui_startup=0
" }}}

" vim-airline {{{
let g:airline#extensions#tabline#enabled = 2
let g:airline#extensions#tabline#fnamemod = ':t'
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline#extensions#tabline#right_sep = ' '
let g:airline#extensions#tabline#right_alt_sep = '|'
let g:airline_left_sep = ' '
let g:airline_left_alt_sep = '|'
let g:airline_right_sep = ' '
let g:airline_right_alt_sep = '|'
"}}}

" NERD Commenter {{{
" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1
" Allow commenting and inverting empty lines (useful when commenting a region)
let g:NERDCommentEmptyLines = 1
" Enable trimming of trailing whitespace when uncommenting
let g:NERDTrimTrailingWhitespace = 1
"########################################################################
" shorcuts: https://github.com/scrooloose/nerdcommenter#default-mappings
" [count]<leader>cc: Comment out the current line or text selected in visual mode.
" [count]<leader>c<space>: Toggles the comment state of the selected line(s). If the topmost selected line is commented, all selected lines are uncommented and vice versa.
" [count]<leader>cu: Uncomments the selected line(s).
"########################################################################
"}}}

" Typescript {{{
" Enable deoplete at startup
let g:deoplete#enable_at_startup = 1
" refresh left bar with tsc: https://github.com/Shougo/deoplete.nvim/issues/492
let g:deoplete#enable_refresh_always = 1
"}}}

" Neomake {{{
" ## Need to add this file to:
" /home/xyz/.local/share/nvim/plugged/neomake/autoload/neomake/makers/ft/typescriptreact.vim
"
" function! neomake#makers#ft#typescriptreact#SupersetOf() abort
    " return 'typescript'
" endfunction
"
" function! neomake#makers#ft#typescriptreact#EnabledMakers() abort
    " return ['tsc', 'tslint']
" endfunction
"
" function! neomake#makers#ft#typescriptreact#tsc() abort
    " let config = neomake#makers#ft#typescript#tsc()
    " let config.args = config.args + ['--jsx', 'preserve']
    " return config
" endfunction
" vim: ts=4 sw=4 et

let g:neomake_open_list = 2
call neomake#configure#automake('rw')
let g:neomake_warning_sign = {
  \ 'text': 'W',
  \ 'texthl': 'WarningMsg',
  \ }
let g:neomake_error_sign = {
  \ 'text': 'E',
  \ 'texthl': 'ErrorMsg',
  \ }
"}}}

" GO {{{
let g:go_fmt_fail_silently = 1
let g:go_fmt_command = "goimports"
let g:go_fmt_fail_silently = 1
let g:go_addtags_transform = "camelcase"
let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_function_calls = 1
" }}}
