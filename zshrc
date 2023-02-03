# colors
autoload -U colors
colors

# "pure" prompt
autoload -U promptinit && promptinit
prompt pure

setopt correct # spelling correction for commands
setopt auto_pushd # make cd work like pushd

autoload compinit
compinit -u # -u skips permission security check (for shared systems)
zstyle ':completion:*' menu select # command completion, with arrow key menu


# ---------------- KEYS ----------------

# Ctrl-X Ctrl-E to edit command in editor
autoload -z edit-command-line
zle -N edit-command-line
bindkey "^X^E" edit-command-line

# Up/Down key history is filtered
bindkey '\e[A' history-search-backward
bindkey '\e[B' history-search-forward

# move words with Ctrl+Arrow
# (must uncheck overlapping shortcuts in Keyboard → Shortcuts → Mission Control)
bindkey -e
bindkey '\e[1;5D' backward-word
bindkey '\e[1;5C' forward-word

# prevent control flow stealing Ctrl-S
stty -ixoff
stty stop undef
stty start undef


# ---------------- HISTORY ----------------

HISTFILE=~/.zsh_history
HISTSIZE=1000
SAVEHIST=$HISTSIZE
setopt append_history
setopt hist_ignore_dups
setopt share_history
setopt hist_ignore_space
setopt hist_ignore_all_dups


# ---------------- PATH ----------------

fpath=(/usr/local/share/zsh-completions $fpath) # add completions to fpath
path=(/usr/local/bin /usr/local/sbin $path) # add /sbin, but keep /bin first
path=(~/Applications/Scripts $path)

# dedupe path
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


# ---------------- HOMEBREW ----------------

export HOMEBREW_NO_ANALYTICS=1

# completion for homebrew
if type brew &>/dev/null; then
  FPATH=$(brew --prefix)/share/zsh/site-functions:$FPATH
fi


# ---------------- INTEGRATIONS ----------------

# use autojump
. `brew --prefix`/etc/profile.d/z.sh

# use iterm2 shell integration
test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

# use rbenv
eval "$(rbenv init -)"

# use fzf
export FZF_DEFAULT_COMMAND='ag -l -p ""'
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# use nvm
export NVM_LAZY_LOAD=true
source ~/.zsh-nvm/zsh-nvm.plugin.zsh

# source aliases & functions
source ~/.aliases
source ~/.functions


# ------------------- ETC -------------------

export EDITOR=vim

cd ~/Developer/Ferraro/Commission/commission_app_ff
