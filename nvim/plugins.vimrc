call plug#begin('~/.local/share/nvim/plugged')

" Theme color
Plug 'NLKNguyen/papercolor-theme'

" Bars
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'vim-airline/vim-airline'
"Plug 'vim-airline/vim-airline-themes' " Dracula already have the theme

" Code edit
Plug 'scrooloose/nerdcommenter'      " Comment lines, blocks
Plug 'editorconfig/editorconfig-vim' " .Editor config

" Auto complete
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }

" Search
Plug '/usr/bin/fzf'
Plug 'junegunn/fzf.vim'

" Buffers
Plug 'Asheq/close-buffers.vim'

" Git
Plug 'tpope/vim-fugitive'

" Go
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries', 'for': 'go' }

" Python
Plug 'vim-scripts/indentpython.vim'

call plug#end()
