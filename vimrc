" Plugins {{{
set nocompatible
filetype off
call plug#begin('~/.vim/plugged')

  Plug 'airblade/vim-gitgutter'             " per-line git status
  Plug 'AndrewRadev/splitjoin.vim'          " split and join lines (gS, sJ)
  Plug 'bkad/CamelCaseMotion'               " move within words
  Plug 'ctrlpvim/ctrlp.vim'                 " fuzzy file finder
   Plug 'jasoncodes/ctrlp-modified.vim'     " adds :CtrlPModified & :CtrlPBranch
  Plug 'ervandew/supertab'                  " tab completion
  Plug 'godlygeek/tabular'                  " column alignment
  Plug 'itchyny/lightline.vim'              " better status line
  Plug 'jceb/vim-orgmode'
  Plug 'jkramer/vim-checkbox'               " toggle checkboxes with <leader>tt
  Plug 'majutsushi/tagbar'                  " in-memory ctags view in a sidebar
  Plug 'mbbill/undotree'                    " visualize the undo tree
  Plug 'mhinz/vim-sayonara'                 " close window and buffer together
  Plug 'michaeljsmith/vim-indent-object'    " text objects based on indent level
  Plug 'ntpeters/vim-better-whitespace'     " show / trim trailing whitespace
  Plug 'scrooloose/nerdtree'                " tree file explorer
  Plug 'scrooloose/syntastic'               " linter integration
  Plug 'sstallion/vim-wildignore'           " read wildignore from a file
  Plug 'terryma/vim-multiple-cursors'       " sublime-style multi select
  Plug 'tomtom/tcomment_vim'                " easy [un]comment. supports blocks, unlike commentary
  Plug 'tpope/tpope-vim-abolish'            " replace words and their variants
  Plug 'tpope/vim-eunuch'                   " :Move, :Rename, :Chmod, etc
  Plug 'tpope/vim-fugitive'                 " :Ggrep, :Gblame, etc
  Plug 'tpope/vim-surround'                 " add / remove / change quotes & brackets
  Plug 'tpope/vim-unimpaired'               " lots more pairwise bracket mappings
  Plug 'xolox/vim-misc'                     " required by vim-notes
  Plug 'xolox/vim-notes'                    " note-taking

  " Color schemes
  " Plug 'chriskempson/base16-vim'          " base16
  " Plug 'davidklsn/vim-sialoquent'         " sialoquent
  " Plug 'jacoborus/tender'                 " tender
  Plug 'jakwings/vim-colors'                " moody

  " Filetype Plugins
  Plug 'dearrrfish/vim-applescript'         " applescript
  Plug 'mtscout6/vim-cjsx'                  " cjsx
  Plug 'kchmck/vim-coffee-script'           " coffeescript
  Plug 'chrisbra/csv.vim'                   " csv
  Plug 'tpope/vim-haml'                     " haml
  Plug 'isRuslan/vim-es6'                   " es6
  Plug 'elzr/vim-json'                      " json
  Plug 'mxw/vim-jsx'                        " jsx
  Plug 'plasticboy/vim-markdown'            " markdown
  Plug 'hdima/python-syntax'                " python (better)
  Plug 'vim-ruby/vim-ruby'                  " ruby
  Plug 'slim-template/vim-slim'             " slim
  Plug 'hashivim/vim-terraform'             " terraform
  Plug 'leafgarland/typescript-vim'         " typescript
  Plug 'Quramy/tsuquyomi'                   " typescript
  Plug 'jlong/sass-convert.vim'             " convert sass <=> scss

  " Ruby & rails tools
  Plug 'ecomba/vim-ruby-refactoring'        " refactoring support
    Plug 'tmhedberg/matchit'                " percent-matching for do/end etc
  Plug 'jgdavey/vim-blockle'                " toggle ruby block types
  Plug 'tpope/vim-endwise'                  " auto-fill 'end' statements
  Plug 'tpope/vim-rails'                    " rails project navigation

  Plug 'jreybert/vimagit'                   " git integration

call plug#end()
" }}}


" Settings {{{
filetype plugin indent on  " load filetype plugins
syntax on " see also ~/.vim/after/syntax/python.vim

colorscheme moody      " previous: molokai, GRB256, base16-default-dark, sialoquent
let mapleader = ","    " use , for <leader>
nmap <Space> ,

set backspace=2        " erase characters not entered during insert mode
set expandtab          " use spaces instead of tabs
set ignorecase         " search is case-insensitive
set noswapfile         " live on the edge
set nowrap             " don't wrap long lines
set number             " show line numbers
set ruler              " show the ruler
set shiftwidth=2       " use indents of 2 spaces
set showmatch          " highlight matching brackets
set smartcase          " search is case-sensitive when uppercase present
set softtabstop=2      " insert 2 spaces on tab / delete 2 spaces on backspace
set t_Co=256           " 256-color term
set tabstop=2          " show 2 spaces per tab
set diffopt+=vertical  " vertical :Gdiff
set wrapscan           " searches wrap

set ttyfast
set lazyredraw
set cursorline

if has('statusline')
  set laststatus=2   " always show the status line
endif

" Strip whitespace on save
autocmd BufWritePre * StripWhitespace

" Filetype-specific settings
autocmd FileType applescript setlocal sw=4 ts=4 sts=4 et
autocmd FileType make set noexpandtab
autocmd FileType python setlocal sw=4 ts=4 sts=4 et
autocmd BufRead,BufWritePre *.html.slim setfiletype slim

" Use ag over grep
if executable('ag')
  set grepprg=ag\ --nogroup\ --nocolor
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g "" -p /Users/john/.ignore'
endif

" Syntastic settings
let g:syntastic_aggregate_errors = 1
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_mode_map = { 'mode': 'passive' }
let g:syntastic_javascript_checkers = ['eslint']
let g:syntastic_ruby_checkers = ['mri', 'rubocop', 'reek']
let g:syntastic_ruby_rubocop_exec = '/Users/john/.rbenv/shims/rubocop'
let g:syntastic_ruby_reek_exec = '/Users/john/.rbenv/shims/reek'
let g:syntastic_scss_checkers = ['scss_lint']
let g:syntastic_scss_scss_lint_exec = '/Users/john/.rbenv/shims/scss-lint'
let g:syntastic_slim_checkers = ['slim_lint']
let g:syntastic_slim_slim_lint_exec = '/Users/john/.rbenv/shims/slim-lint'
let g:syntastic_python_checkers = ['python', 'pylint']
let g:syntastic_python_pylint_exec = '/usr/local/bin/pylint'
let g:syntastic_quiet_messages = { 'regex': 'fixme' }
let g:syntastic_loc_list_height = 3
let g:vim_markdown_folding_disabled = 1

" Other plugin settings
let g:NERDTreeRespectWildIgnore = 1
let g:NERDTreeWinPos = "right"
let g:notes_directories = ['~/Documents/Notes']
let g:notes_smart_quotes = 0
let g:notes_suffix = '.txt'
let g:python_highlight_all = 1
let g:python_version_2 = 1
let g:rspec_command = "! vagrant ssh -c 'cd /app && bin/rspec {spec} '"
let g:startify_bookmarks = [{'b': '~/Desktop/work/status.txt'}, {'a': '~/Desktop/today.md'}]
let g:startify_change_to_dir = 0

" iTerm: use thin cursor
if $TERM_PROGRAM =~ "iTerm"
  let &t_SI = "\<Esc>]50;CursorShape=1\x7" " Vertical bar in insert mode
  let &t_EI = "\<Esc>]50;CursorShape=0\x7" " Block in normal mode
endif

" GUI vim settings
if has('gui_running')
  set colorcolumn=100
  set guifont=SFMono-Light:h14  " Range\ Mono\ Medium, Input, Monaco, Menlo
  set linespace=2
  set columnspace=-1
  set transparency=2
  highlight ColorColumn guibg=Gray10

  " start in project
  cd ~/Developer/Gradescope/gradescope-app
  let g:ctrlp_working_path_mode = 0
endif
" }}}


" Functions {{{
function! ToggleList(bufname, pfx) " Toggle the location or quickfix list
  let buflist = GetBufferList()
  for bufnum in map(filter(split(buflist, '\n'), 'v:val =~ "'.a:bufname.'"'), 'str2nr(matchstr(v:val, "\\d\\+"))')
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

function! s:RunShellCommand(cmdline) " Used by :Shell
  echo a:cmdline
  let expanded_cmdline = a:cmdline
  for part in split(a:cmdline, ' ')
     if part[0] =~ '\v[%#<]'
        let expanded_part = fnameescape(expand(part))
        let expanded_cmdline = substitute(expanded_cmdline, part, expanded_part, '')
     endif
  endfor
  botright new
  setlocal buftype=nofile bufhidden=wipe nobuflisted noswapfile nowrap
  call setline(1, 'You entered:    ' . a:cmdline)
  call setline(2, 'Expanded Form:  ' .expanded_cmdline)
  call setline(3,substitute(getline(2),'.','=','g'))
  execute '$read !'. expanded_cmdline
  setlocal nomodifiable
  1
endfunction
" }}}


" Commands {{{
command! Configure  edit $MYVIMRC
command! Source     source $MYVIMRC
command! WildIgnore edit ~/.vim/wildignore
command! Wd         write | bdelete
command! Bd         bdelete
command! BBD        bufdo bdelete
command! Switch     cd ../../Liftbook/liftbook-app
command! Status     edit ~/Desktop/work/status.txt
command! Trans      set transparency=16
command! Solid      set transparency=2

" runs a shell command in a new window
command! -complete=shellcmd -nargs=+ Shell call s:RunShellCommand(<q-args>)

cmap w!!            w !sudo tee % >/dev/null
" }}}


" Mappings {{{
noremap  <Up>       <NOP>
noremap  <Down>     <NOP>
noremap  <Left>     <NOP>
noremap  <Right>    <NOP>

" Return to normal mode from home row. Disabling Esc to build the habit
inoremap jk <Esc>
inoremap <Esc> <Nop>

" Yank to the end of the line, like C and D.
nnoremap Y y$

" Easier horizontal movement
nnoremap zl zL
nnoremap zh zH

" Move line under cursor with Alt-j or Alt-k (mac-specific)
nnoremap ∆ :m .+1<CR>==
nnoremap ˚ :m .-2<CR>==

" Toggle location or quickfix list easily
nnoremap <silent> <leader>l :call ToggleList("Location List", 'l')<CR>
nnoremap <silent> <leader>c :call ToggleList("Quickfix List", 'c')<CR>

" Keep the current indentation level, even if the previous line is blank
inoremap <CR> <CR>x<BS>

nnoremap <leader>dg2   :diffget //2<CR>
nnoremap <leader>dg3   :diffget //3<CR>
nnoremap <leader>du    :diffupdate<CR>

nnoremap <leader>i     i_<Esc>r
" }}}


" Plugin Mappings {{{
nmap \               <Plug>(easymotion-sn)
omap \               <Plug>(easymotion-tn)

nnoremap <leader>a     {v}:Tabularize /
vnoremap <leader>a     :Tabularize /
nnoremap <leader><Tab> {v}:Tabularize /
vnoremap <leader><Tab> :Tabularize /

nnoremap <leader>n     :NERDTreeFind<CR>
nnoremap <leader>s     :SyntasticCheck<CR>

nnoremap <leader>m     :CtrlPModified<CR>
nnoremap <leader>r     :CtrlPMRUFiles<CR>
nnoremap <leader>B     :CtrlPBranch<CR>
nnoremap <leader>t     :CtrlP<CR>
nnoremap <leader>M     :CtrlPMRU<CR>

" nnoremap <leader>p     :Pytest file<CR>

" vim-checkbox: use <leader>x instead of <leader>tt
silent! nunmap <silent> <leader>tt
nnoremap <silent> <leader>x :ToggleCB<cr>

nnoremap <leader>g     :TagbarToggle<CR>
nnoremap <F8>          :TagbarToggle<CR>

" makes Alt-w move forward by word within snake & camelcase (& ignore punctuation)
" TODO: figure out why this doesn't work
" nnoremap ∑ <Plug>CamelCaseMotion_w

" makes <leader>w/b/e/ge move by word within snake & camelcase (& ignore punctuation)
call camelcasemotion#CreateMotionMappings('<leader>')
" }}}


" Misc {{{
" make TODO, etc. gray instead of neon
hi clear Todo
hi Todo guifg=#888888 guibg=#1a1a1a
hi clear PreProc
hi PreProc guifg=#888888 guibg=#1a1a1a
" }}}
