# vi: ft=zsh

BREW_PREFIX=$(brew --prefix)

# -----------------------------------------------------------------------------
# settings
# -----------------------------------------------------------------------------

# colors
autoload -U colors
colors

export LS_COLORS="$(vivid generate one-dark)"

# prompt
if [[ "$TERM_PROGRAM" != "vscode" ]]; then
  autoload -U promptinit && promptinit
  prompt pure
fi

setopt correct # spelling correction
setopt auto_pushd # make cd work like pushd


# -----------------------------------------------------------------------------
# shell completions
# -----------------------------------------------------------------------------

source $BREW_PREFIX/share/zsh-autosuggestions/zsh-autosuggestions.zsh

zstyle ':completion:*' menu select # use arrow key menu
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}' # case-insensitive
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS} # colorized

fpath=($BREW_PREFIX/share/zsh-completions $fpath)
fpath=($BREW_PREFIX/share/zsh/site-functions $fpath)
fpath=($HOME/.docker/completions $fpath)
fpath=($HOME/.zsh/completions $fpath) # hand-installed. lefthook, supabase, etc

autoload -Uz compinit
compinit -u # -u skips permission security check


# -----------------------------------------------------------------------------
# history
# -----------------------------------------------------------------------------

HISTFILE=$HOME/.zsh_history
HISTSIZE=10000
SAVEHIST=$HISTSIZE
setopt append_history
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt share_history
setopt hist_verify # show command before running with !!


# -----------------------------------------------------------------------------
# keybindings
# -----------------------------------------------------------------------------

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


# -----------------------------------------------------------------------------
# path & integrations
# -----------------------------------------------------------------------------

# my stuff
path+=($HOME/Applications/Scripts)

# vscode integration
[[ "$TERM_PROGRAM" == "vscode" ]] && . "$(code --locate-shell-integration-path zsh)"

# z / autojump
. $BREW_PREFIX/etc/profile.d/z.sh

# fzf
export FZF_DEFAULT_COMMAND='ag -l -p ""'
source <(fzf --zsh)

# direnv
eval "$(direnv hook zsh)"

# cdpath
cdpath=(~ ~/Developer/Ferraro ~/Developer/Sonicbids)


# -----------------------------------------------------------------------------
# extra commands
# -----------------------------------------------------------------------------

source ~/.aliases
source ~/.functions
