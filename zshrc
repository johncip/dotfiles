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
compinit -u # -u skips permission security check (for shared systems)
zstyle ':completion:*' menu select

# Edit command in editor (emacs-style)
autoload -z edit-command-line
zle -N edit-command-line
bindkey "^X^E" edit-command-line

# Up/down key history is filtered
bindkey '\e[A' history-search-backward
bindkey '\e[B' history-search-forward

# Move words with ctrl+arrow
# (make sure to uncheck corresponding shortcuts in
#    System Preferences → Keyboard → Shortcuts → Mission Control)
bindkey -e
bindkey '\e[1;5D' backward-word
bindkey '\e[1;5C' forward-word

# turn off control flow stealing Ctrl-S
stty -ixoff
stty stop undef
stty start undef


# History
HISTFILE=~/.zsh_history
HISTSIZE=1000
SAVEHIST=$HISTSIZE
setopt append_history
setopt hist_ignore_dups
setopt share_history
setopt hist_ignore_space
setopt hist_ignore_all_dups

# Autojump
. `brew --prefix`/etc/profile.d/z.sh

function mkcd() {
  mkdir -p "$1" && cd "$1"
}

# Functions
function grep_ruby() {
  find app lib -name '*.rb' | xargs grep $*
}

function brew_tree() {
  brew list | while read cask
  do echo -n $fg[blue] $cask $fg[white]
    brew deps $cask | awk '{printf(" %s ", $0)}'
    echo ""
  done
}

function restart_sound() {
  sudo kill -9 `ps ax|grep 'coreaudio[a-z]' | awk '{print $2}'`
}

function remove_dsstore() {
  find . -d -name ".DS_Store" -exec rm -v {} \;
}

function print_conflicts() {
  ag -r '(>{7})|(<{7})'
}

function list_instances() {
  local region="$1"
  aws ec2 describe-instances \
    --region ${region:-`aws configure get region`} \
    --query='Reservations[*].Instances[*].[PublicIpAddress, InstanceId, Tags[?Key==`Name`].Value | [0]]' \
    --output table
}

# Add completions to fpath
fpath=(/usr/local/share/zsh-completions $fpath)

path=(~/Applications/Scripts $path)

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

export HOMEBREW_NO_ANALYTICS=1

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

eval "$(rbenv init -)"
# export PATH="/Users/john/miniconda3/bin:$PATH"

# tabtab source for serverless package
# uninstall by removing these lines or running `tabtab uninstall serverless`
[[ -f /usr/local/lib/node_modules/serverless/node_modules/tabtab/.completions/serverless.zsh ]] && . /usr/local/lib/node_modules/serverless/node_modules/tabtab/.completions/serverless.zsh
# tabtab source for sls package
# uninstall by removing these lines or running `tabtab uninstall sls`
[[ -f /usr/local/lib/node_modules/serverless/node_modules/tabtab/.completions/sls.zsh ]] && . /usr/local/lib/node_modules/serverless/node_modules/tabtab/.completions/sls.zsh

export FZF_DEFAULT_COMMAND='ag -l -p ""'

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# . "/usr/local/opt/nvm/nvm.sh"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
# -- NOTE: nvm is very slow to load. replacing with an alias to be called manually
# [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
alias loadnvm='[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"'
