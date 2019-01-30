" ALE
let g:ale_sign_column_always = 1
let g:ale_linters = {'ruby': ['ruby'], 'javascript': ['eslint'], 'typescript': ['tslint', 'tsserver']}
let g:ale_fixers = { 'javascript': ['prettier', 'eslint'], 'typescript': ['prettier', 'tslint'] }
let g:ale_fix_on_save = 1
let g:ale_lint_on_text_changed = 'always'
let g:ale_sign_column_always = 1

noremap <Leader>gd :ALEGoToDefinition<CR>
noremap <Leader>gh :ALEHover<CR>
