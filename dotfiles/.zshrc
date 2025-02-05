# -- general settings ---------------------------------------------------------

# colors
autoload -U colors
colors

# pure prompt
autoload -U promptinit && promptinit
prompt pure

setopt correct # spelling correction
setopt auto_pushd # make cd work like pushd


# -- tab completion -----------------------------------------------------------

fpath=($(brew --prefix)/share/zsh-completions $fpath)
fpath=($(brew --prefix)/share/zsh/site-functions $fpath)

autoload -Uz compinit
compinit -u # -u skips permission security check (for shared systems)

zstyle ':completion:*' menu select # command completion, with arrow key menu


# -- history ------------------------------------------------------------------

HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=$HISTSIZE
setopt append_history
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt share_history


# -- keybindings --------------------------------------------------------------

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


# -- path & integrations ------------------------------------------------------

# NOTE: asdf shims are installed in .zshenv

path+=(~/Applications/Scripts)
path+=(/Applications/dsdriver/bin)
path+=(/usr/local/sbin)

# aliases & functions
source ~/.aliases
source ~/.functions

# autojump
. `brew --prefix`/etc/profile.d/z.sh

# fzf
export FZF_DEFAULT_COMMAND='ag -l -p ""'
source <(fzf --zsh)

# iterm2 shell integration
test -e "${HOME}/.iterm2_shell_integration.zsh" \
  && source "${HOME}/.iterm2_shell_integration.zsh"

# install asdf shims
. $(brew --prefix asdf)/libexec/asdf.sh
