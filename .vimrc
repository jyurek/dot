set nocompatible
call plug#begin('~/.vim/plugged')

Plug 'AndrewRadev/linediff.vim'
Plug 'BlakeWilliams/vim-tbro'
Plug 'PeterRincker/vim-argumentative'
Plug 'christoomey/vim-conflicted'
Plug 'christoomey/vim-tmux-navigator'
Plug 'elixir-lang/vim-elixir'
Plug 'ElmCast/elm-vim'
Plug 'int3/vim-extradite'
Plug 'janko-m/vim-test'
Plug 'leafgarland/typescript-vim'
Plug 'gabrielelana/vim-markdown'
Plug 'mbbill/undotree'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'pangloss/vim-javascript'
Plug 'pbrisbin/vim-mkdir'
Plug 'peitalin/vim-jsx-typescript'
Plug 'prettier/vim-prettier', {
  \ 'do': 'yarn install',
  \ 'for': ['javascript', 'typescript', 'css', 'less', 'scss', 'json', 'graphql', 'markdown', 'vue', 'yaml', 'html'] }
Plug 'psf/black', { 'branch': 'stable' }
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-projectionist'
Plug 'tpope/vim-rails'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-vinegar'
Plug 'vim-ruby/vim-ruby'
Plug 'vim-scripts/ReplaceWithRegister'
Plug '/usr/local/opt/fzf'
Plug 'yssl/QFEnter'

" colorschemes
Plug 'chriskempson/tomorrow-theme', {'rtp': 'vim'}
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'morhetz/gruvbox'
Plug 'rakr/vim-one'

call plug#end()

" Softtabs, 2 spaces
set tabstop=2
set shiftwidth=2
set expandtab

set backspace=indent,eol,start
set nobackup
set nowritebackup
set noswapfile
set history=50                         " keep 50 lines of command line history
set ruler                              " show the cursor position all the time
set incsearch                          " do incremental searching
set hlsearch                           " highlight the search
set list listchars=tab:»·,trail:·      " Display whitespace
set number                             " show absolute line numbers
set splitbelow                         " Open hsplits below the current one
set splitright                         " Open vsplits to the right of the current one
set cursorline                         " Highlight the row the cursor is on
set spellfile=~/.vim/custom-spellings.en.add
set nofoldenable
set wildmode=longest,list:longest      " bash like command line tab completion
set virtualedit=block,onemore          " Allow moving past the end of the line
set scrolloff=15                       " Provide lines of context
set mouse=nir                          " Enable mouse for scrolling in terminal
set path+=**
set colorcolumn=81
set autoread
set lazyredraw                         " Don't redraw during a macro
set suffixesadd=.md                    " Also search for `thing.md` if you gd on `thing`

" Tab-complete options
set complete=.,w,b,u,t,kspell
set completeopt=longest,menu

" Global Undo
set undofile
set undodir=~/.vimundo

" Allow yanking to OS clipboard
set clipboard=unnamed,unnamedplus

" Per-project .vimrc files
set exrc
set secure

" Coloration
if &t_Co > 2 || has("gui_running") " &t_Co => terminal has colors
  set t_Co=256
  set background=dark
  colorscheme gruvbox
  let g:gruvbox_italicize_strings = '1'
endif

syntax on

if has("autocmd")
  filetype plugin on
  filetype indent on

  augroup myFileTypeSettings
    " delete all autocommand settings in this group
    au! 

    au! BufRead,BufNewFile .autotest setfiletype ruby 
    au! BufRead,BufNewFile *.haml setfiletype haml 
    au! BufRead,BufNewFile *.sass setfiletype sass
    au! BufRead,BufNewFile *.textile setfiletype textile

    autocmd FileType text setlocal textwidth=78
    autocmd FileType gitcommit setlocal textwidth=78
    " JSON Comments
    autocmd FileType json syntax match Comment +\/\/.\+$+

    " When editing a file, always jump to the last known cursor position.
    " Don't do it when the position is invalid or when inside an event handler
    " (happens when dropping a file on gvim).
    autocmd BufReadPost *
      \ if line("'\"") > 0 && line("'\"") <= line("$") |
      \   exe "normal g`\"" |
      \ endif
  augroup END
endif

" If possible, try to use a narrow number column.
if v:version >= 700
    try
        setlocal numberwidth=3
    catch
    endtry
endif

" Remap autocomplete to Tab
inoremap <Tab> <C-N>
inoremap <S-Tab> <C-P>

" No Help, please
noremap <F1> <Esc>
inoremap <F1> <Esc>
cnoremap <F1> <Esc>

" Extradite, git history browser
nnoremap <F11> :Extradite!<CR>
let g:extradite_width = 80

" Easier to remember Redo
nnoremap U :redo<Enter>

" Move around splits with Control-Arrows
let g:tmux_navigator_no_mappings = 1
vnoremap <silent> <C-H> <Esc>:TmuxNavigateLeft<cr>
vnoremap <silent> <C-J> <Esc>:TmuxNavigateDown<cr>
vnoremap <silent> <C-K> <Esc>:TmuxNavigateUp<cr>
vnoremap <silent> <C-L> <Esc>:TmuxNavigateRight<cr>
vnoremap <silent> <C-\> <Esc>:TmuxNavigatePrevious<cr>
inoremap <silent> <C-H> <Esc>:TmuxNavigateLeft<cr>
inoremap <silent> <C-J> <Esc>:TmuxNavigateDown<cr>
inoremap <silent> <C-K> <Esc>:TmuxNavigateUp<cr>
inoremap <silent> <C-L> <Esc>:TmuxNavigateRight<cr>
inoremap <silent> <C-\> <Esc>:TmuxNavigatePrevious<cr>
nnoremap <silent> <C-H> :TmuxNavigateLeft<cr>
nnoremap <silent> <C-J> :TmuxNavigateDown<cr>
nnoremap <silent> <C-K> :TmuxNavigateUp<cr>
nnoremap <silent> <C-L> :TmuxNavigateRight<cr>
nnoremap <silent> <C-\> :TmuxNavigatePrevious<cr>

let g:tmux_navigator_save_on_switch = 1

" Use <C-x>s for finding spelling correction possibilities.
nnoremap z= i<C-x>s

" Leader mappings
let mapleader=" "
map <Leader>h :nohls<Enter>
nmap <Leader>, :up<CR>:cp<CR>
nmap <Leader>. :up<CR>:cn<CR>
nmap <Leader>; lF:xepldf>
nmap <Leader>< :up<CR>:cpf<CR>
nmap <Leader>= mmgg=G`mzz
nmap <Leader>> :up<CR>:cnf<CR>
nmap <Leader>I o\|> (fn (l) -> Logger.info(": " <> inspect(l)); l end).()<Esc>F:i
nmap <Leader>d Orequire 'pry'; binding.pry<Esc>:w<CR>
nmap <Leader>diff mdjV/=====<CR>k"fynjV/>>>>><CR>k"sy:vne<CR>"fP:diffthis<CR>:vne<CR>"sP:diffthis<CR>
nmap <Leader>ee :e <C-R>=expand("%:p:h") . '/'<CR>
nmap <Leader>es :split <C-R>=expand("%:p:h") . '/'<CR>
nmap <Leader>ev :vnew <C-R>=expand("%:p:h") . '/'<CR>
nmap <Leader>i o\|> IO.inspect(label: "")<Esc>F"i
nmap <Leader>o :w \| !open %<CR>
nmap <Leader>q gwip
nmap <Leader>rc :source $MYVIMRC<CR>
nmap <Leader>rce :tabedit $MYVIMRC<CR>
nmap <Leader>rr :redr!<CR>
nmap <Leader>sao Osave_and_open_page<Esc>:w<CR>
nmap <Leader>saos Osave_and_open_screenshot(nil, full: true)<Esc>:w<CR>
nmap <Leader>u :UndotreeToggle<CR>
nmap <Leader>p :Prettier<CR>
nmap <Leader>f :copen<CR>
nmap <Leader>F :cclose<CR>

" Turn a path relative to % into a path relative to vim's pwd.
nmap <Leader>R m`f'l"pdi'i<C-r>=resolve(expand("%:h") . "/<C-r>"")<CR><ESC>``

" Actually do searching with the silver searcher if available
" https://github.com/ggreer/the_silver_searcher
cnoreabbrev ag grep
if executable("ag")
  set grepprg=ag\ --vimgrep
  set grepformat=%f:%l:%c:%m
endif

" Search the project for the word under the cursor.
nnoremap K :silent grep! "<C-R><C-W>"<CR><C-L>
autocmd QuickFixCmdPost *grep* cwindow

" Treat <li> and <p> tags like the block tags they are
let g:html_indent_tags = 'li\|p'

" Settings for Markdown
au BufNewFile,BufReadPost *.md set filetype=markdown
au BufNewFile,BufReadPost *.md setlocal spell
au BufNewFile,BufReadPost *.md setlocal textwidth=80
au BufNewFile,BufReadPost *.md setlocal includeexpr=substitute(v:fname,'^/','','g')
au BufNewFile,BufReadPost *.md setlocal suffixesadd+=.md
let g:markdown_fenced_languages = ['coffee', 'css', 'erb=eruby', 'javascript', 'js=javascript', 'json=javascript', 'ruby', 'sass', 'xml', 'html']

" Make sure we can bracket via ruby blocks
runtime macros/matchit.vim

" Streamline !
nnoremap ! :Tbro 
nnoremap !! :TbroRedo<CR>
command! TbroLine call tbro#run_line()
nnoremap !x :TbroLine<CR>

" vim-test mappings, suggested from the README
nmap <silent> <Leader>t :TestNearest<CR>
nmap <silent> <Leader>T :TestFile<CR>
nmap <silent> <Leader>a :TestSuite<CR>
nmap <silent> <Leader>l :TestLast<CR>
nmap <silent> <Leader>g :TestVisit<CR>

" vim-test transformation
function! AlertTransformation(cmd) abort
  return a:cmd . " && lt 'Pass' || lt 'Fail'"
endfunction
let g:test#custom_transformations = {'alert': function('AlertTransformation')}
let g:test#transformation = 'alert'

" vim-test Strategy
let g:test#custom_strategies = {'tbro': function('tbro#send')}
let g:test#strategy = 'tbro'

let &t_SI = "\x1b[\x35 q"
let &t_SR = "\x1b[\x33 q"
let &t_EI = "\x1b[\x30 q"

" elm
let g:elm_format_autosave = 1

" Prettier
let g:prettier#config#parser = 'babylon'

nmap <leader>ss :call <SID>SynStack()<CR>
function! <SID>SynStack()
  if !exists("*synstack")
    return
  endif
  echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc

"""""""""""""""""""""
" COC Configuration
"""""""""""""""""""""

" TextEdit might fail if hidden is not set.
set hidden

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Give more space for displaying messages.
" set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use <Leader>d to show documentation in preview window.
nnoremap <leader>d :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Python
nmap <Leader>pl :cexpr system("pipenv run flake8 . --no-show-source --format='%(path)s:%(row)d: %(code)s %(text)s'")<Enter>:copen<Enter>
