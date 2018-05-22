set nocompatible
call plug#begin('~/.vim/plugged')

Plug 'BlakeWilliams/vim-tbro'
Plug 'PeterRincker/vim-argumentative'
Plug 'bernerdschaefer/vim-null'
Plug 'christoomey/vim-conflicted'
Plug 'christoomey/vim-tmux-navigator'
Plug 'elixir-lang/vim-elixir'
Plug '~/Development/elm-vim'
Plug 'int3/vim-extradite'
Plug 'janko-m/vim-test'
Plug 'kien/ctrlp.vim'
Plug 'kisom/eink.vim'
Plug 'lukerandall/haskellmode-vim'
Plug 'mbbill/undotree'
Plug 'morhetz/gruvbox'
Plug 'pbrisbin/vim-mkdir'
Plug 'slim-template/vim-slim'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-flagship'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-projectionist'
Plug 'tpope/vim-rails'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-vinegar'
Plug 'vim-ruby/vim-ruby'
Plug 'vim-scripts/ReplaceWithRegister'
Plug 'w0rp/ale'
Plug 'rhysd/vim-crystal'
Plug 'kchmck/vim-coffee-script'

call plug#end()


" Softtabs, 2 spaces
set tabstop=2
set shiftwidth=2
set expandtab

set backspace=indent,eol,start
set nobackup
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
set scrolloff=15                       " Provide eleven lines of context
set mouse=nir                          " Enable mouse for scrolling in terminal
set path+=**
set colorcolumn=81
set autoread

" flagship
set showtabline=1
set laststatus=2
set guioptions-=e

" Tab-complete options
set complete=.,w,b,u,t,kspell
set completeopt=longest,menu

" Global Undo
set undofile
set undodir=~/.vimundo

" Per-project .vimrc files
set exrc
set secure

" This will use the unnamed register as the system clipboard
set clipboard=unnamed

" Coloration
if &t_Co > 2 || has("gui_running") " &t_Co => terminal has colors
  set t_Co=256
  set background=dark
  let g:gruvbox_italic = 0
  colorscheme gruvbox
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

" This doesn't come up often, but this is totally useful when it does.
" nnoremap jj <Esc>
" inoremap jj <Esc>

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
noremap U :redo<Enter>

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
nmap <Leader>diff jdV/====<CR>kd:vne<CR>P<C-w>hjV/>>>><CR>kd:vne<CR>P:diffthis<C-w>l:diffthis<CR>
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
nmap <Leader>w :w<CR>

" Actually do searching with the silver searcher if available
" https://github.com/ggreer/the_silver_searcher
cnoreabbrev ag grep
if executable("ag")
  set grepprg=ag\ --nogroup\ --nocolor\ --column

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor --hidden -g ""'

  " ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0
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
  return "docker-compose run web ".a:cmd
  " ." && pass || fail"
endfunction
let g:test#custom_transformations = {'alert': function('AlertTransformation')}
let g:test#transformation = 'alert'

" vim-test Strategy
let g:test#custom_strategies = {'tbro': function('tbro#send')}
let g:test#strategy = 'tbro'

" " Syntastic
" let g:syntastic_check_on_open = 1
" let g:syntastic_ruby_exec = '/usr/local/rubies/mri-2.3.3/bin/ruby'
" let g:syntastic_always_populate_loc_list = 1

" Use line cursor in insert mode, block in normal (only in tmux)
if exists('$TMUX')
    let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
    let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
else
    let &t_SI = "\<Esc>]50;CursorShape=1\x7"
    let &t_EI = "\<Esc>]50;CursorShape=0\x7"
endif

" haskellmode
let g:haddock_browser = "/Applications/Firefox.app"

" elm
let g:elm_format_autosave = 1

" ALE
let g:ale_sign_column_always = 1
let g:ale_linters = {'ruby': ['ruby']} " disable most ruby linting

" mix format
" let g:mix_format_on_save = 1
" let g:mix_format_elixir_bin_path = '~/.asdf/installs/elixir/1.6.0-rc.0/bin'
