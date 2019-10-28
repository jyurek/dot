augroup netrw_local_extensions
  autocmd!
  autocmd FileType netrw call s:setup_netrw_local_extensions()
augroup END

function! s:setup_netrw_local_extensions() abort
"   nmap <buffer> R :edit .<CR>
endfunction
