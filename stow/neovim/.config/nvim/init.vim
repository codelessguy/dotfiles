call plug#begin('~/.local/share/nvim/plugged')

" Theme color
Plug 'NLKNguyen/papercolor-theme'

" Bars
" Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes' " Dracula already have the theme

" Code edit
Plug 'scrooloose/nerdcommenter'      " Comment lines, blocks
Plug 'editorconfig/editorconfig-vim' " .Editor config

" Search
Plug '~/.fzf'
Plug 'junegunn/fzf.vim'

" Buffers
Plug 'Asheq/close-buffers.vim'

" Auto complete
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" C/C++
" Plug 'Valloric/YouCompleteMe'

" Git
"Plug 'tpope/vim-fugitive'

" Auto complete
"Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }

" Language server
"Plug 'autozimu/LanguageClient-neovim', {
"    \ 'branch': 'next',
"    \ 'do': 'bash install.sh',
"    \ }

" Go
" Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries', 'for': 'go' }

" Python
" Plug 'vim-scripts/indentpython.vim'

call plug#end()

source $HOME/.config/nvim/general.vimrc
source $HOME/.config/nvim/theme.vimrc
source $HOME/.config/nvim/nerdcommenter.vimrc
source $HOME/.config/nvim/vim-airline.vimrc
source $HOME/.config/nvim/fzf.vimrc
source $HOME/.config/nvim/coc.vimrc
