" Settings for Ale
let g:ale_lint_on_text_changed = 'never'
let g:ale_sign_column_always = 1
let g:ale_statusline_format = ['⨉ %d', '⚠ %d', '⬥ ok']
let g:ale_javascript_eslint_executable = 'eslint_d'
let g:ale_sign_error = '✗'
let g:ale_sign_warning = '⚠'

augroup AleGroup
    autocmd!
    autocmd User ALELint call TouchOpenFile()
augroup END

func! TouchOpenFile()
    let g:ale_enabled = 0
    sleep 500m
    w                                                 
    let g:ale_enabled = 1
endfunc
