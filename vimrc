"----------------------------------------------------------------------------------------
" Plugins
"----------------------------------------------------------------------------------------
set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
  Plugin 'VundleVim/Vundle.vim'               " required

  Plugin 'airblade/vim-gitgutter'             " per-line git status
  Plugin 'bkad/CamelCaseMotion'               " move within words
  Plugin 'ctrlpvim/ctrlp.vim'                 " fuzzy file finder
    Plugin 'jasoncodes/ctrlp-modified.vim'    " adds :CtrlPModified & :CtrlPBranch
  Plugin 'easymotion/vim-easymotion'          " jump to search results
  Plugin 'ervandew/supertab'                  " tab completion
  Plugin 'flazz/vim-colorschemes'             " colorscheme pack
  Plugin 'gcmt/wildfire.vim'                  " select increasing scopes
  Plugin 'godlygeek/tabular'                  " column alignment
  Plugin 'haya14busa/incsearch.vim'           " for easymotion
  Plugin 'itchyny/lightline.vim'              " better status line
  Plugin 'jacoborus/tender'                   " colorscheme
  Plugin 'michaeljsmith/vim-indent-object'    " text objects based on indent level
  Plugin 'mileszs/ack.vim'                    " use ack to search code
  Plugin 'nathanaelkane/vim-indent-guides'    " show indent with vertical lines (toggle: <L>ig)
  Plugin 'ntpeters/vim-better-whitespace'     " show / trim trailing whitespace
  Plugin 'scrooloose/nerdtree'                " tree file explorer
    Plugin 'Xuyuanp/nerdtree-git-plugin'      " show git status in NERDtree
  Plugin 'scrooloose/syntastic'               " linter integration
  Plugin 'terryma/vim-multiple-cursors'       " sublime-style multi select
  Plugin 'tomtom/tcomment_vim'                " easy [un]comment. supports blocks ,unlike commentary
  Plugin 'tpope/vim-eunuch'                   " :Move, :Rename, :Chmod, etc
  Plugin 'tpope/vim-fugitive'                 " :Ggrep, :Gblame, etc
  Plugin 'tpope/vim-surround'                 " add / remove / change quotes & brackets
  Plugin 'tpope/vim-unimpaired'               " lots more pairwise bracket mappings

  " Language support
  Plugin 'dearrrfish/vim-applescript'         " applescript
  Plugin 'mtscout6/vim-cjsx'                  " cjsx
  Plugin 'kchmck/vim-coffee-script'           " coffeescript
  Plugin 'tpope/vim-haml'                     " haml
  Plugin 'pangloss/vim-javascript'            " javascript
  Plugin 'elzr/vim-json'                      " json
  Plugin 'mxw/vim-jsx'                        " jsx
  Plugin 'plasticboy/vim-markdown'            " markdown
  Plugin 'hdima/python-syntax'                " python (better)
  Plugin 'vim-ruby/vim-ruby'                  " ruby
  Plugin 'slim-template/vim-slim'             " slim
  Plugin 'hashivim/vim-terraform'             " terraform
  Plugin 'jlong/sass-convert.vim'             " convert sass <=> scss

  " Ruby & rails tools
  Plugin 'ecomba/vim-ruby-refactoring'        " refactoring support
    Plugin 'tmhedberg/matchit'                " percent-matching for do/end etc
  Plugin 'jgdavey/vim-blockle'                " toggle ruby block types
  Plugin 'tpope/vim-endwise'                  " auto-fill 'end' statements
  Plugin 'tpope/vim-rails'                    " rails project navigation

call vundle#end()
filetype plugin indent on  " required


"----------------------------------------------------------------------------------------
" Settings
"----------------------------------------------------------------------------------------
syntax on
" colorscheme molokai
colorscheme GRB256
let mapleader = ","

set number           " show line numbers
set ruler            " show the ruler
set nowrap           " don't wrap long lines
set noswapfile       " live on the edge
set ignorecase       " search is case-insensitive
set smartcase        " search is case-sensitive when uppercase present
set t_Co=256         " 256-color term
set showmatch        " highlight matching brackets
set expandtab        " use spaces instead of tabs
set shiftwidth=2     " use indents of 2 spaces
set tabstop=2        " show 2 spaces per tab
set softtabstop=2    " insert 2 spaces on tab / delete 2 spaces on backspace
set backspace=2      " erase characters not entered during insert mode

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
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
endif

" Syntastic settings
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_loc_list_height = 3
let g:syntastic_auto_loc_list = 1
" let g:syntastic_check_on_open = 0
" let g:syntastic_check_on_wq = 0
let g:syntastic_mode_map = { 'mode': 'passive' }
let g:syntastic_quiet_messages = { 'regex': 'fixme' }

let g:syntastic_coffee_checkers        = ['coffeelint']
let g:syntastic_javascript_checkers    = ['eslint']
let g:syntastic_python_checkers        = ['python', 'pylint']
let g:syntastic_ruby_checkers          = ['mri', 'rubocop', 'reek']
let g:syntastic_scss_checkers          = ['scss-lint']
let g:syntastic_slim_checkers          = ['slim-lint']
let g:syntastic_coffee_coffeelint_exec = '/usr/local/lib/ruby/gems/2.3.0/gems/coffeelint-1.14.0/bin/coffeelint.rb'
let g:syntastic_python_pylint_exec     = '/usr/local/bin/pylint'
let g:syntastic_ruby_reek_exec         = '/usr/local/bin/reek'
let g:syntastic_ruby_rubocop_exec      = '/usr/local/bin/rubocop'
let g:syntastic_scss_scss_lint_exec    = '/usr/local/bin/scss-lint'
let g:syntastic_slim_slim_lint_exec    = '/usr/local/bin/slim-lint'

" Other plugin settings
let g:python_version_2 = 1
let g:python_highlight_all = 1
let g:rspec_command = "! vagrant ssh -c 'cd /app && bin/rspec {spec} '"

" iTerm: use thin cursor
if $TERM_PROGRAM =~ "iTerm"
  let &t_SI = "\<Esc>]50;CursorShape=1\x7" " Vertical bar in insert mode
  let &t_EI = "\<Esc>]50;CursorShape=0\x7" " Block in normal mode
endif

" MacVim settings
if has('gui_running')
  set colorcolumn=100
  " set guifont=Input:h15
  " set macligatures
  highlight ColorColumn guibg=Gray10

  " start in project
  let g:ctrlp_working_path_mode = 0
  cd ~/Developer/Gradescope/gradescope-app
endif

"----------------------------------------------------------------------------------------
" Functions
"----------------------------------------------------------------------------------------
" Toggle the location or quickfix list
function! ToggleList(bufname, pfx)
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

" Needed for ToggleList
function! GetBufferList()
  redir =>buflist
  silent! ls!
  redir END
  return buflist
endfunction

" Used by :Shell
function! s:RunShellCommand(cmdline)
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


"----------------------------------------------------------------------------------------
" Commands
"----------------------------------------------------------------------------------------
command! Configure :edit $MYVIMRC
command! Source    :source $MYVIMRC
command! Wd        write | bdelete

" :Shell -- Run shell command and show output in a new window
command! -complete=shellcmd -nargs=+ Shell call s:RunShellCommand(<q-args>)


"----------------------------------------------------------------------------------------
" Mappings
"----------------------------------------------------------------------------------------
" Disable arrow keys
noremap  <Up>       <NOP>
noremap  <Down>     <NOP>
noremap  <Left>     <NOP>
noremap  <Right>    <NOP>

" Use space to find next space in line
noremap  <Space> f<Space>

" Return to normal mode from home row
inoremap jk <Esc>

" Yank to the end of the line, like C and D.
nnoremap Y y$

" Easier horizontal movement
nnoremap zl zL
nnoremap zh zH

" Move line under cursor with Alt-j or Alt-k
nnoremap ∆ :m .+1<CR>==
nnoremap ˚ :m .-2<CR>==

" Toggle location or quickfix list easily
nnoremap <silent> <leader>l :call ToggleList("Location List", 'l')<CR>
nnoremap <silent> <leader>c :call ToggleList("Quickfix List", 'c')<CR>

" Plugins
nmap \               <Plug>(easymotion-sn)
omap \               <Plug>(easymotion-tn)

nnoremap <leader>a     {v}:Tabularize /
vnoremap <leader>a     :Tabularize /
nnoremap <leader><Tab> {v}:Tabularize /
vnoremap <leader><Tab> :Tabularize /

nnoremap <leader>n     :NERDTreeFind<CR>
nnoremap <leader>s     :SyntasticCheck<CR>

nnoremap <leader>m     :CtrlPModified<CR>
inoremap <leader>m     <Esc>:CtrlPModified<CR>
nnoremap <leader>B     :CtrlPBranch<CR>
inoremap <leader>B     <Esc>:CtrlPBranch<CR>
inoremap <leader>t     <Esc>:CtrlP<CR>
nnoremap <leader>t     :CtrlP<CR>
nnoremap <leader>M     :CtrlPMRU<CR>


" makes <leader>w/b/e/ge move by word within snake & camelcase (& ignore punctuation)
call camelcasemotion#CreateMotionMappings('<leader>')

" For when you forget to sudo... really write the file.
cmap w!! w !sudo tee % >/dev/null
