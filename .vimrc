call plug#begin('~/.vim/plugged')

Plug 'junegunn/vim-easy-align'

" Fix copy and paste
Plug 'svermeulen/vim-easyclip'
" easyclip dep
Plug 'tpope/vim-repeat'

" Files
Plug 'scrooloose/nerdtree'

" Bar
Plug 'vim-airline/vim-airline'
"Plug 'vim-airline/vim-airline-themes' " Dracula already have the theme

" File search
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" Move
Plug 'easymotion/vim-easymotion'

" Theme
Plug 'morhetz/gruvbox'
Plug 'NLKNguyen/papercolor-theme'
" Plug 'junegunn/seoul256.vim'
Plug 'dracula/vim'
"Plug 'vim-scripts/pyte'

" Show color
Plug 'lilydjwg/colorizer'

call plug#end()

"
" RELOAD VIM !!!
" :so $MYVIMRC


let mapleader = ','

" base config: http://nerditya.com/code/guide-to-neovim/

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
set esckeys             " Cursor keys in insert mode.
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

" Copy buffer into x clipboard 
set clipboard=unnamedplus
set noswapfile

"""""""""
" Theme "
"""""""""
syntax on
set t_Co=256
" set background=light
" colorscheme PaperColor
colorscheme dracula
" colorscheme gruvbox
" colorscheme pyte

"""""""""""""""
" Move around "
"""""""""""""""
noremap <C-k> 5k
noremap <C-j> 5j

" Move between panes with , + arrow keys
nmap <silent> <Leader><Up> :wincmd k<CR>
nmap <silent> <Leader><Down> :wincmd j<CR>
nmap <silent> <Leader><Left> :wincmd h<CR>
nmap <silent> <Leader><Right> :wincmd l<CR>
" Or use C-W h,j,k,l


"""""""""""""
" NERDTree
"""""""""""""
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


"""""""""""""
" vim-airline
"""""""""""""
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

"""""""
" fzf "
"""""""
nnoremap <silent> <Leader>f :Files<CR>
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
