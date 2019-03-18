" ===================================================================
" Plugins
" ===================================================================
"
set nocompatible
filetype off
call plug#begin('~/.vim/plugged')

Plug 'w0rp/ale'
Plug 'bkad/CamelCaseMotion'
Plug 'jasoncodes/ctrlp-modified.vim'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'ervandew/supertab'
Plug 'mkitt/tabline.vim'
Plug 'godlygeek/tabular', { 'on': 'Tabularize' }
Plug 'majutsushi/tagbar'
Plug 'tomtom/tcomment_vim'
Plug 'tpope/tpope-vim-abolish'
Plug 'vim-airline/vim-airline'
Plug 'ntpeters/vim-better-whitespace'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'terryma/vim-multiple-cursors'
Plug 'prettier/vim-prettier', { 'on': ['Prettier', 'PrettierAsync'] }
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'

" filetypes
Plug 'chrisbra/csv.vim',        { 'for': 'csv'        }
Plug 'ElmCast/elm-vim',         { 'for': 'elm'        }
Plug 'hdima/python-syntax',     { 'for': 'python'     }
Plug 'isRuslan/vim-es6',        { 'for': 'javascript' }
Plug 'elzr/vim-json',           { 'for': 'json'       }
Plug 'plasticboy/vim-markdown', { 'for': 'markdown'   }
Plug 'vim-ruby/vim-ruby',       { 'for': 'ruby'       }

" colorschemes
Plug 'johncip/nord-vim'
Plug 'jakwings/vim-colors' " moody
" Plug 'chriskempson/base16-vim'
" Plug 'maksimr/Lucius2'
" Plug 'tomasr/molokai'
" Plug 'jacoborus/tender'
" Plug 'promisedlandt/vim-colors-ir_black'

filetype plugin indent on
syntax on
call plug#end()


" ===================================================================
" Settings
" ===================================================================
"
let mapleader = ','

colorscheme nord
highlight Comment cterm=italic

set colorcolumn=100
set cursorline
set cmdheight=1
set ignorecase
set laststatus=2
set lazyredraw
set modeline
set nohlsearch
set noshowmode
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

" grep using ag
if executable('ag')
  set grepprg=ag\ --nogroup\ --nocolor
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
endif

if has('gui_running')
  set guifont=FiraCode-Light:h15
endif

" Plugin settings
let g:ale_fixers = {
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
\   'javascript': ['prettier', 'eslint'],
\}
let g:better_whitespace_enabled = 1
let g:colorizer_colornames_disable = 1
let g:csv_highlight_column = 'y'
let g:csv_no_conceal = 1
let g:ctrlp_max_files = 0
let g:ctrlp_show_hidden = 1
let g:ctrlp_working_path_mode = 0
let g:elm_setup_keybindings = 0
let g:NERDTreeDirArrows = 1
let g:NERDTreeMinimalUI = 1
let g:NERDTreeWinPos = "right"
let g:nord_italic = 1
let g:nord_italic_comments = 1
let g:nord_cursor_line_number_background = 1
let g:prettier#config#bracket_spacing = 'true'
let g:prettier#config#semi = 'false'
let g:prettier#config#trailing_comma = 'none'
let g:prettier#exec_cmd_async = 1
let g:python_highlight_all = 1
let g:strip_whitespace_confirm = 0
let g:strip_whitespace_on_save = 1
let g:vim_markdown_folding_disabled = 1


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

" keep current indentation level when previous line is blank
inoremap <cr>       <cr>x<BS>

" move line with alt-j / alt-k
nnoremap <m-j>      :m .+1<cr>==
nnoremap <m-k>      :m .-2<cr>==

" macvim tab shortcuts for vimR
nnoremap <D-s>      :w<cr>
nnoremap <D-S-[>    :tabp<cr>
nnoremap <D-S-]>    :tabn<cr>

nnoremap <silent> <leader>l :call ToggleList("Location List", 'l')<cr>
nnoremap <silent> <leader>c :call ToggleList("Quickfix List", 'c')<cr>


" ===================================================================
" Plugin Mappings
" ===================================================================
"
call camelcasemotion#CreateMotionMappings('<leader>')

nnoremap <leader><Tab> {v}:Tabularize /
vnoremap <leader><Tab> :Tabularize /
nnoremap <leader>a     :ALEFix<cr>
nnoremap <leader>B     :CtrlPBranch<cr>
nnoremap <leader>m     :CtrlPModified<cr>
nnoremap <leader>n     :NERDTreeFind<cr>
nnoremap <leader>o     :ColorHighlight<cr>
nnoremap <leader>t     :CtrlP<cr>
nnoremap <leader>z     :ALEDetail<cr>
nnoremap <F8>          :TagbarToggle<cr>
nnoremap <D-S-{>       :tabp<cr>
nnoremap <D-S-}>       :tabn<cr>
