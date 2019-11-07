" RELOAD VIM !!!
" :so $MYVIMRC

" BASE CONFIG: http://nerditya.com/code/guide-to-neovim/
let mapleader = ','

set showcmd             " Show (partial) command in status line.
set showmatch           " Show matching brackets.
set showmode            " Show current mode.
set ruler               " Show the line and column numbers of the cursor.
set number              " Show the line numbers on the left side.
set formatoptions+=o    " Continue comment marker in new lines.
set textwidth=0         " Hard-wrap long lines as you type them.
" set expandtab           " Insert spaces when TAB is pressed.
set tabstop=4           " Render TABs using this many spaces.
set shiftwidth=4        " Indentation amount for < and > commands.
set autoindent
set noexpandtab

set noerrorbells        " No beeps.
set modeline            " Enable modeline.
set linespace=0         " Set line-spacing to minimum.
set nojoinspaces        " Prevents inserting two spaces after punctuation on a join (J)

set autowrite           " Auto save changes before switching buffer

" More natural splits
set splitbelow          " Horizontal split below current.
set splitright          " Vertical split to right of current.

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
" Enable folding with the spacebar
" nnoremap <space> za

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
nnoremap <silent> <C-q> :Bdelete hidden<CR>
" CLose all buffers except the current one
" noremap <Leader>ab :%bd|e#|bd#<CR>
" bufdo bd   " close all buffers
" }}}

" turn relative line numbers on
set relativenumber
set rnu


" Avoid copy when delete
" source: https://stackoverflow.com/questions/11993851/how-to-delete-not-cut-in-vim
nnoremap <leader>d "_d
xnoremap <leader>d "_d
xnoremap <leader>p "_dP
nnoremap x "_x

" Disable arrow keys
noremap <Up> <Nop>
noremap <Down> <Nop>
noremap <Left> <Nop>
noremap <Right> <Nop>

" Disable auto comment insertion
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" Automatically fill
"inoremap " ""<left>
"inoremap ' ''<left>
"inoremap ( ()<left>
"inoremap [ []<left>
"inoremap { {}<left>
"inoremap {<CR> {<CR>}<ESC>O
"inoremap {;<CR> {<CR>};<ESC>O
