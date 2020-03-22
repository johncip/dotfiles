" ===================================================================
" Plugins
" ===================================================================
"
set nocompatible
filetype off
call plug#begin('~/.vim/plugged')

Plug 'dense-analysis/ale'
Plug 'bkad/CamelCaseMotion'
Plug 'scrooloose/nerdtree', { 'on': ['NERDTreeToggle', 'NERDTreeFind'] }
Plug 'ervandew/supertab'
Plug 'godlygeek/tabular', { 'on': 'Tabularize' }
Plug 'majutsushi/tagbar'
Plug 'tomtom/tcomment_vim'
Plug 'tpope/tpope-vim-abolish'
Plug 'vim-airline/vim-airline'
Plug 'ntpeters/vim-better-whitespace'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'ludovicchabant/vim-gutentags'
Plug 'terryma/vim-multiple-cursors'
Plug 'prettier/vim-prettier', { 'on': ['Prettier', 'PrettierAsync'] }
Plug 'tpope/vim-repeat'
Plug 'thoughtbot/vim-rspec'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'

" clojure
Plug 'junegunn/rainbow_parentheses.vim'
Plug 'guns/vim-sexp'
Plug 'tpope/vim-sexp-mappings-for-regular-people'
Plug 'tpope/vim-fireplace'
Plug 'tpope/vim-salve'
" Plug 'bhurlow/vim-parinfer'
" Plug 'clojure-vim/clj-refactor.nvim'


Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf.vim'

" filetypes
Plug 'sheerun/vim-polyglot'
Plug 'chrisbra/csv.vim',        { 'for': 'csv' }
Plug 'ElmCast/elm-vim',         { 'for': 'elm' }

" colorschemes
Plug 'johncip/nord-vim'
Plug 'jakwings/vim-colors' " moody
Plug 'chriskempson/base16-vim' " base16-classic-dark
Plug 'tomasr/molokai'
" Plug 'promisedlandt/vim-colors-ir_black'
" Plug 'jacoborus/tender'
" Plug 'maksimr/Lucius2'

filetype plugin indent on
syntax on
call plug#end()

" ===================================================================
" Settings
" ===================================================================
"
let mapleader = ','

colorscheme base16-classic-dark
highlight Comment cterm=italic gui=italic
highlight Todo ctermbg=NONE ctermfg=yellow guibg=NONE guifg=orange

set clipboard=unnamed
set colorcolumn=100
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
  set grepprg=ag\ --nogroup\ --nocolor
endif

if has('gui_running')
  set guifont=FiraCode-Light:h15
endif

" Plugin settings
let g:ale_fixers = {
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
\   'javascript': ['prettier', 'eslint'],
\}
let g:ale_ruby_rubocop_executable = 'bin/rubocop'
let g:better_whitespace_ctermcolor = 'Black'
let g:better_whitespace_guicolor = 'Black'
let g:colorizer_colornames_disable = 1
let g:csv_highlight_column = 'y'
let g:csv_no_conceal = 1
let g:elm_setup_keybindings = 0
let g:gutentags_file_list_command = 'ag -l'
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
let $FZF_DEFAULT_COMMAND = 'ag -g ""'

" ===================================================================
" Functions
" ===================================================================
"
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


" ===================================================================
" Commands
" ===================================================================
"
command! Bd             bdelete
command! Bda            bufdo | bd
command! Config         edit $MYVIMRC
command! -nargs=1 Grep  silent! grep! <f-args> | :call ToggleList('Quickfix List', 'c')
command! Wd             write | bdelete
cmap w!!                w !sudo tee % >/dev/null


" ===================================================================
" Mappings
" ===================================================================
"
inoremap jk         <Esc>
nnoremap Y          y$

nnoremap <silent> <Up>    :Files<cr>
nnoremap <silent> <Down>  :Buffers<cr>
nnoremap <silent> <Left>  :bprev<cr>
nnoremap <silent> <Right> :bnext<cr>

" keep current indentation level when previous line is blank
inoremap <cr>       <cr>x<BS>

" move line with alt-j / alt-k
" nnoremap <m-j>      :m .+1<cr>==
" nnoremap <m-k>      :m .-2<cr>==

nnoremap <silent> <leader>l :call ToggleList("Location List", 'l')<cr>
nnoremap <silent> <leader>c :call ToggleList("Quickfix List", 'c')<cr>

nnoremap <silent> <F9> :write<cr>:Require<cr>:%Eval<cr>
" nnoremap <F10> :%Eval


" ===================================================================
" Plugin Mappings
" ===================================================================
"
call camelcasemotion#CreateMotionMappings('<leader>')

nnoremap <leader><Tab> {v}:Tabularize /
vnoremap <leader><Tab> :Tabularize /
nnoremap <leader>a     :ALEFix<cr>
nnoremap <leader>L     :Lines<cr>
nnoremap <leader>m     :GFiles?<cr>
nnoremap <leader>n     :NERDTreeFind<cr>
nnoremap <leader>o     :ColorHighlight<cr>
nnoremap <Leader>s     :call RunCurrentSpecFile()<cr>
nnoremap <leader>t     :Files<cr>
nnoremap <leader>z     :ALEDetail<cr>
nnoremap <F8>          :TagbarToggle<cr>
