# Colors
autoload -U colors
colors

# "Pure" Prompt
autoload -U promptinit && promptinit
prompt pure

# Spelling correction for commands
setopt correct

# Make cd work like pushd
setopt auto_pushd

# Command completion, with arrow key menu
autoload compinit
compinit
zstyle ':completion:*' menu select

# Edit command in editor (emacs-style)
autoload -z edit-command-line
zle -N edit-command-line
bindkey "^X^E" edit-command-line

# Up/down key history is filtered
bindkey '\e[A' history-search-backward
bindkey '\e[B' history-search-forward

# Move words with ctrl+arrow
bindkey -e
bindkey '\e[1;5D' backward-word
bindkey '\e[1;5C' forward-word

# History
setopt APPEND_HISTORY
setopt HIST_IGNORE_DUPS
setopt EXTENDED_HISTORY
setopt SHARE_HISTORY

# Autojump
. `brew --prefix`/etc/profile.d/z.sh

# Functions
function grep-ruby() {
  find app lib -name '*.rb' | xargs grep $*
}

function brew-tree() {
  brew list | while read cask
  do echo -n $fg[blue] $cask $fg[white]
    brew deps $cask | awk '{printf(" %s ", $0)}'
    echo ""
  done
}

function restart-sound() {
  sudo kill -9 `ps ax|grep 'coreaudio[a-z]' | awk '{print $2}'`
}

function remove-dsstore() {
  find . -d -name ".DS_Store" -exec rm -v {} \;
}

# Add completions to fpath
fpath=(/usr/local/share/zsh-completions $fpath)

# Path: add /usr/local/sbin, put usr/local first
export PATH="/usr/local/bin:/usr/local/sbin:$PATH"

# Source aliases
source ~/.aliases

# Dedupe path
if [ -n "$PATH" ]; then
  old_PATH=$PATH:; PATH=
  while [ -n "$old_PATH" ]; do
    x=${old_PATH%%:*}       # the first remaining entry
    case $PATH: in
      *:"$x":*) ;;          # already there
      *) PATH=$PATH:$x;;    # not there yet
    esac
    old_PATH=${old_PATH#*:}
  done
  PATH=${PATH#:}
  unset old_PATH x
fi


if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"
