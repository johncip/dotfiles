" ===================================================================================
" Plugins
" ===================================================================================
"
set nocompatible
filetype off
call plug#begin('~/.vim/plugged')

Plug 'AndrewRadev/bufferize.vim'
Plug 'AndrewRadev/splitjoin.vim'
Plug 'airblade/vim-gitgutter'
Plug 'bkad/CamelCaseMotion'
Plug 'dense-analysis/ale'
Plug 'ervandew/supertab'
Plug 'godlygeek/tabular', { 'on': 'Tabularize' }
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'ludovicchabant/vim-gutentags'
Plug 'majutsushi/tagbar'
Plug 'ntpeters/vim-better-whitespace'
Plug 'prettier/vim-prettier', { 'on': ['Prettier', 'PrettierAsync'] }
Plug 'scrooloose/nerdtree', { 'on': ['NERDTreeToggle', 'NERDTreeFind'] }
Plug 'sheerun/vim-polyglot'
Plug 'terryma/vim-multiple-cursors'
Plug 'tomtom/tcomment_vim'
Plug 'tpope/tpope-vim-abolish'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'vim-airline/vim-airline'
" Plug 'fatih/vim-go'
" Plug 'chrisbra/csv.vim',        { 'for': 'csv' }
" Plug 'ElmCast/elm-vim',         { 'for': 'elm' }

" ruby on rails
Plug 'ecomba/vim-ruby-refactoring'
Plug 'itmammoth/run-rspec.vim'
Plug 'tpope/vim-rails'

" clojure
" Plug 'junegunn/rainbow_parentheses.vim'
" Plug 'guns/vim-sexp'
" Plug 'tpope/vim-sexp-mappings-for-regular-people'
" Plug 'tpope/vim-fireplace'
" Plug 'tpope/vim-salve'
" Plug 'bhurlow/vim-parinfer'
" Plug 'clojure-vim/clj-refactor.nvim'

" colorschemes
Plug 'johncip/nord-vim'          " nord
Plug 'jakwings/vim-colors'       " moody
" Plug 'chriskempson/base16-vim'   " base16-classic-dark, base16-tomorrow-night
Plug 'tomasr/molokai'            " molokai
Plug 'maksimr/Lucius2'           " lucius


filetype plugin indent on
syntax on
call plug#end()

" ===================================================================================
" Settings
" ===================================================================================

let mapleader = ','

colorscheme molokai

highlight Comment cterm=italic gui=italic
highlight Todo ctermbg=NONE ctermfg=yellow guibg=NONE guifg=orange

set clipboard=unnamed
set colorcolumn=""
set cursorline
set cmdheight=1
set hidden
set ignorecase
set laststatus=2
set lazyredraw
set modeline
set nohlsearch
set noshowmode
set nospell
set noswapfile
set nowrap
set number
set ruler
set showmatch
set splitbelow
set splitright
set smartcase
set t_Co=256
set termguicolors
set ttyfast
set updatetime=100
set wildmenu
set wrapscan

set expandtab
set copyindent
set preserveindent
set softtabstop=2
set shiftwidth=2
set tabstop=2

set listchars=eol:$,tab:>-,trail:~,extends:>,precedes:<,space:·

autocmd FileType applescript setlocal sw=4 ts=4 sts=4 et
autocmd FileType make set noexpandtab
autocmd FileType python setlocal sw=4 ts=4 sts=4 et
autocmd BufRead,BufWritePre *.html.slim setfiletype slim

" use thin cursor in iTerm
if $TERM_PROGRAM =~ "iTerm"
  let &t_SI = "\<Esc>]50;CursorShape=1\x7" " Vertical bar in insert mode
  let &t_EI = "\<Esc>]50;CursorShape=0\x7" " Block in normal mode
endif

" use mouse in iTerm
set mouse=a
if has("mouse_sgr")
  set ttymouse=sgr
end

" grep using ag
if executable('ag')
  set grepprg=ag\ --nogroup\ --nocolor\ --hidden\ --ignore\ .git\ --ignore\ \"*.csv\"\ --ignore\ \"import/*.json\"
endif

if has('gui_running')
  set guifont=Dank\ Mono:h16
endif

" ===================================================================================
" Plugin settings
" ===================================================================================

" linting
let g:ale_lint_delay = 100
let g:ale_fixers = {
\    '*': ['remove_trailing_lines', 'trim_whitespace'],
\    'javascript': ['prettier', 'eslint'],
\    'ruby': ['rubocop', 'reek'],
\    'scss': ['stylelint'],
\}
let g:ale_ruby_rubocop_executable = 'bin/rubocop'
let g:ale_ruby_reek_executable = 'bin/reek'

" tagging
let g:gutentags_file_list_command = 'ag -l'
let g:gutentags_ctags_exclude = [
\    'node_modules',
\    'coverage',
\    'vendor',
\    'app/assets/builds',
\    'app/assets/images',
\    'import/*.json',
\    'import/*.csv',
\    'spec/support/data',
\    ]
let g:tagbar_type_ruby = {
\    'kinds': ['m:modules',
\              'F:singleton methods',
\              'f:methods',
\              'a:aliases',
\              'd:describes',
\              'i:its',
\              'c:contexts',
\              'C:contexts']
\    }
let g:tagbar_type_scss = {
\    'kinds': ['P:placeholder classes',
\              'c:classes',
\              'f:functions',
\              'i:identities',
\              'm:mixins',
\              'v:variables',
\              'z:function parameters']
\    }

let g:airline_powerline_fonts = 1
" let g:airline_symbols_ascii = 1
let g:better_whitespace_ctermcolor = 'Black'
let g:better_whitespace_guicolor = 'Black'
let g:colorizer_colornames_disable = 1
let g:csv_highlight_column = 'y'
let g:csv_no_conceal = 1
let g:elm_setup_keybindings = 0
let g:NERDTreeDirArrows = 1
let g:NERDTreeMinimalUI = 1
let g:NERDTreeWinPos = "right"
let g:nord_comment_brightness = 15
let g:nord_italic = 1
let g:prettier#config#bracket_spacing = 'true'
let g:prettier#config#semi = 'false'
let g:prettier#config#trailing_comma = 'none'
let g:prettier#exec_cmd_async = 1
let g:strip_whitespace_confirm = 0
let g:strip_whitespace_on_save = 1
let g:vim_markdown_folding_disabled = 1

" use ag in fzf even when opened outside of a terminal session
let $FZF_DEFAULT_COMMAND = 'ag --hidden --ignore .git -g ""'

" ===================================================================================
" Functions
" ===================================================================================

function! ToggleList(bufname, pfx) " Toggle the location or quickfix list
  let buflist = GetBufferList()
  for bufnum in map(filter(split(buflist, '\n'), 'v:val =~ "'.a:bufname.'"'),
      \ 'str2nr(matchstr(v:val, "\\d\\+"))')
    if bufwinnr(bufnum) != -1
      exec(a:pfx.'close')
      return
    endif
  endfor
  if a:pfx == 'l' && len(getloclist(0)) == 0
      echohl ErrorMsg
      echo "Location List is Empty."
      return
  endif
  let winnr = winnr()
  exec(a:pfx.'open')
  if winnr() != winnr
    wincmd p
  endif
endfunction

function! GetBufferList() " Needed for ToggleList
  redir =>buflist
  silent! ls!
  redir END
  return buflist
endfunction

function! Grep(term, ...) abort
  execute 'silent! grep!' a:term join(a:000, ' ')
  cwindow
  redraw!
endfunction

" ===================================================================================
" Commands
" ===================================================================================

command! Bw             bprevious | bdelete# " close buffer but leave window
command! Bd             bdelete " for fat-fingering
command! Bda            silent! bufdo | bd
command! Config         edit $MYVIMRC
command! Wd             write | bdelete
cmap w!!                w !sudo tee % >/dev/null

command! -nargs=+ -complete=file Grep call Grep(<f-args>)

" ===================================================================================
" Mappings
" ===================================================================================

inoremap jk         <Esc>
nnoremap Y          y$

nnoremap <silent> <Up>    :Files<cr>
nnoremap <silent> <Down>  :GFiles?<cr>
nnoremap <silent> <Left>  :bprev<cr>
nnoremap <silent> <Right> :bnext<cr>

" keep current indentation level when previous line is blank
inoremap <cr>       <cr>x<BS>

nnoremap <silent> <leader>l :call ToggleList("Location List", 'l')<cr>
nnoremap <silent> <leader>c :call ToggleList("Quickfix List", 'c')<cr>

" ===================================================================================
" Plugin Mappings
" ===================================================================================

call camelcasemotion#CreateMotionMappings('<leader>')

nnoremap <leader><Tab> {v}:Tabularize /
vnoremap <leader><Tab> :Tabularize /
nnoremap <leader>a     :ALEToggle<cr>
nnoremap <leader>A     :ALEFix<cr>
nnoremap <leader>L     :Lines<cr>
nnoremap <leader>n     :NERDTreeFind<cr>
nnoremap <leader>t     :Files<cr>
nnoremap <leader>z     :ALEDetail<cr>
nnoremap <F5>          :set list!<cr>
nnoremap <F8>          :TagbarToggle<cr>

" running rspec
nnoremap <leader>S             :RunSpec<CR>
nnoremap <leader>s             :RunSpecLine<CR>
nnoremap <leader>sl            :RunSpecLastRun<CR>
nnoremap <leader>sc            :RunSpecCloseResult<CR>
nnoremap <leader><leader>s     :vsplit \| terminal bin/rspec %<cr>
nnoremap <leader><leader>sa    :vsplit \| terminal bin/rspec<cr>
nnoremap <leader><leader>sf    :vsplit \| terminal bin/rspec --only-failures<cr>

" ===================================================================================
" Do Last
" ===================================================================================

