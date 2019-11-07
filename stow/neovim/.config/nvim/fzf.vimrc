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
