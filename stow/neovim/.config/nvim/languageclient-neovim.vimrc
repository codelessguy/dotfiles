" Required for operations modifying multiple buffers like rename.
set hidden

" For c/cpp need to compile like this: cmake -DCMAKE_EXPORT_COMPILE_COMMANDS=ON .. && make -j4
let g:LanguageClient_serverCommands = {
    \ 'rust': ['~/.cargo/bin/rustup', 'run', 'stable', 'rls'],
    \ 'c': ['clangd', '-compile-commands-dir=' . getcwd() . '/build'],
    \ 'cpp': ['clangd', '-compile-commands-dir=' . getcwd() . '/build'],
    \ }

" Automatically start language servers.
let g:LanguageClient_autoStart = 1

nnoremap <F5> :call LanguageClient_contextMenu()<CR>
" Or map each action separately
nnoremap <silent> K :call LanguageClient#textDocument_hover()<CR>
nnoremap <silent> gd :call LanguageClient#textDocument_definition()<CR>
nnoremap <silent> <F2> :call LanguageClient#textDocument_rename()<CR>
