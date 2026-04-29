" ===================================================================================
" Plugins
" ===================================================================================
"
set nocompatible
filetype off
call plug#begin('~/.vim/plugged')

Plug 'AndrewRadev/bufferize.vim'
Plug 'AndrewRadev/splitjoin.vim'
Plug 'adelarsq/vim-matchit'
Plug 'airblade/vim-gitgutter'
Plug 'bkad/CamelCaseMotion'
Plug 'dense-analysis/ale'
Plug 'ervandew/supertab'
Plug 'github/copilot.vim'
Plug 'godlygeek/tabular', { 'on': 'Tabularize' }
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'majutsushi/tagbar'
Plug 'ntpeters/vim-better-whitespace'
Plug 'prettier/vim-prettier', { 'on': ['Prettier', 'PrettierAsync'] }
Plug 'scrooloose/nerdtree', { 'on': ['NERDTreeToggle', 'NERDTreeFind'] }
Plug 'sheerun/vim-polyglot'
Plug 'tomtom/tcomment_vim'
Plug 'tpope/tpope-vim-abolish'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" ruby on rails
Plug 'ecomba/vim-ruby-refactoring'
Plug 'itmammoth/run-rspec.vim'
Plug 'tpope/vim-rails'

" clojure
" Plug 'junegunn/rainbow_parentheses.vim'
" Plug 'tpope/vim-fireplace'
" Plug 'tpope/vim-salve'
" Plug 'bhurlow/vim-parinfer'

" colorschemes
Plug 'arcticicestudio/nord-vim'  " nord
Plug 'gmist/vim-palette'         " moody, base16-*
Plug 'tomasr/molokai'            " molokai


filetype plugin indent on
syntax on
call plug#end()


" ===================================================================================
" Color Settings
" ===================================================================================

" good color schemes:
"   nord, moody, molokai, base16-default-dark
colorscheme base16-default-dark

" set termguicolors
set colorcolumn=""
set t_Co=256

" to remove background:
"   hi! Normal ctermbg=NONE guibg=NONE

" change background color of cursor line, but don't lose syntax highlighting
set cursorline
highlight CursorLine cterm=NONE ctermbg=236 ctermfg=NONE guibg=#2c2c2c guifg=NONE

" special styling for comments and todos
highlight Comment cterm=italic gui=italic
highlight Todo ctermbg=NONE ctermfg=yellow guibg=NONE guifg=orange


" ===================================================================================
" General Settings
" ===================================================================================

let mapleader = ','

set clipboard=unnamed
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

set errorformat=%f:%l:%c:%m,%f:%l:%m

autocmd FileType applescript setlocal sw=4 ts=4 sts=4 et
autocmd FileType make set noexpandtab
autocmd FileType python setlocal sw=4 ts=4 sts=4 et
autocmd BufRead,BufNewFile *.html.slim set filetype=slim
autocmd BufRead,BufNewFile *.pdf.erb set filetype=eruby.html

" disable copilot for doing learning exercises
autocmd FileType clojure :Copilot disable


" ===================================================================================
" GUI & Terminal settings
" ===================================================================================

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

if exists("g:neovide")
  " NOTE: more font settings in ~/.config/neovide/config.toml
  set linespace=1

  " Disable animations
  let g:neovide_position_animation_length = 0
  let g:neovide_cursor_animation_length = 0.00
  let g:neovide_cursor_trail_size = 0
  let g:neovide_cursor_animate_in_insert_mode = 'false'
  let g:neovide_cursor_animate_command_line = 'false'
  let g:neovide_scroll_animation_far_lines = 0
  let g:neovide_scroll_animation_length = 0.00

  " Allow copy paste in neovim
  let g:neovide_input_use_logo = 1
  map <D-v> "+p<CR>
  map! <D-v> <C-R>+
  tmap <D-v> <C-R>+
  vmap <D-c> "+y<CR>

  " Increase / decrease font size with Cmd- +/-
  let g:neovide_scale_factor=1.0
  function! ChangeScaleFactor(delta)
    let g:neovide_scale_factor = g:neovide_scale_factor * a:delta
  endfunction
  nnoremap <expr><D-=> ChangeScaleFactor(1.1)
  nnoremap <expr><D--> ChangeScaleFactor(1/1.1)
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
let g:ale_scss_stylelint_executable = 'bin/stylelint'

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
let g:copilot_node_command= '/Users/john/.asdf/shims/node'
let g:csv_highlight_column = 'y'
let g:csv_no_conceal = 1
let g:elm_setup_keybindings = 0
let g:NERDTreeDirArrows = 1
let g:NERDTreeMinimalUI = 1
let g:NERDTreeWinPos = "right"
let g:nord_italic = 1
let g:nord_italic_comments = 1
let g:prettier#config#bracket_spacing = 'true'
let g:prettier#config#semi = 'false'
let g:prettier#config#trailing_comma = 'none'
let g:prettier#exec_cmd_async = 1
let g:run_rspec_bin = 'bin/rspec'
let g:strip_whitespace_confirm = 0
let g:strip_whitespace_on_save = 1
let g:vim_markdown_folding_disabled = 1

" use ag in fzf even when opened outside of a terminal session
let $FZF_DEFAULT_COMMAND = 'ag --hidden --ignore .git -g ""'


" ===================================================================================
" Grep with ag & add the Grep command
" ===================================================================================

if executable('ag')
  set grepprg=ag\ --vimgrep\ --nogroup\ --nocolor\ --hidden\ --ignore\ .git\ --ignore\ \"*.csv\"\ --ignore\ \"import/*.json\"
  " set grepprg=ag\ --vimgrep\ --nogroup\ --nocolor
endif

function! Grep(term, ...) abort
  setlocal errorformat=%f:%l:%m
  execute 'silent! grep!' a:term join(a:000, ' ')
  cwindow
  redraw!
endfunction


" ===================================================================================
" Show the location & quickfix list
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

nnoremap <silent> <leader>l :call ToggleList("Location List", 'l')<cr>
nnoremap <silent> <leader>c :call ToggleList("Quickfix List", 'c')<cr>


" ===================================================================================
" Use @ in visual mode to constrain macros
" ===================================================================================

xnoremap @ :<C-u>call ExecuteMacroOverVisualRange()<CR>

function! ExecuteMacroOverVisualRange()
    echo "@".getcmdline()
      execute ":'<,'>normal @".nr2char(getchar())
    endfunction


" ===================================================================================
" Commands
" ===================================================================================

command! Bw             bprevious | bdelete# " close buffer but leave window
command! Bd             bdelete " for fat-fingering
command! Vsplit         vsplit  " for fat-fingering
command! Bda            silent! bufdo | bd
command! Config         edit $MYVIMRC
command! Wd             write | bdelete
cmap w!!                w !sudo tee % >/dev/null

command! -nargs=+ -complete=file Grep call Grep(<f-args>)


" ===================================================================================
" Mappings
" ===================================================================================

" jk exits insert mode
inoremap jk         <Esc>

" prefix with leader to move by individual words in camel case
call camelcasemotion#CreateMotionMappings('<leader>')

" keep current indentation level when previous line is blank
inoremap <cr>       <cr>x<BS>

" shift+y yanks to end of line
nnoremap Y          y$

" tab to cycles through buffers
"
" previously:
"   " left and right for buffers
"   nnoremap <silent> <Left>  :bprev<cr>
"   nnoremap <silent> <Right> :bnext<cr>
nnoremap <silent> <Tab>   :bnext<CR>
nnoremap <silent> <S-Tab> :bprev<CR>

" left and right for cycling through panes
nnoremap <Left>  <C-w>W
nnoremap <Right> <C-w>w

" up and down open fzf
nnoremap <silent> <Up>    :Files<cr>
nnoremap <silent> <Down>  :GFiles?<cr>

" leader-m for fzf within file
nnoremap <leader>m        :Lines<cr>

" leader-tab for tabularize
nnoremap <leader><Tab>    {v}:Tabularize /
vnoremap <leader><Tab>    :Tabularize /

" ale
nnoremap <leader>a        :ALEToggle<cr>
nnoremap <leader>A        :ALEFix<cr>
nnoremap <leader>z        :ALEDetail<cr>

" other plugins
nnoremap <leader>n        :NERDTreeFind<cr>
nnoremap <F8>             :TagbarToggle<cr>

" rspec
nnoremap <leader>S             :RunSpec<CR>
nnoremap <leader>s             :RunSpecLine<CR>
nnoremap <leader>sl            :RunSpecLastRun<CR>
nnoremap <leader>sc            :RunSpecCloseResult<CR>
nnoremap <leader><leader>s     :vsplit \| terminal bin/rspec %<cr>
nnoremap <leader><leader>sa    :vsplit \| terminal bin/rspec<cr>
nnoremap <leader><leader>sf    :vsplit \| terminal bin/rspec --only-failures<cr>


" ===================================================================================
" Project Setup
" ===================================================================================

" cd ~/Developer/Ferraro/Commission/commission_reporter
" cd ~/Developer/Super8/super8
" cd ~/Developer/Ferraro/PO/po_forecaster
cd ~/Developer/Sonicbids/advance-crm
