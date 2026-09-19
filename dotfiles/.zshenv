# don't read global RC files (e.g. /etc/zshrc)
#
# the default ones on mac include `path_helper` which puts the system entries
# ahead of e.g. asdf shims
unsetopt GLOBAL_RCS

# -----------------------------------------------------------------------------
# env vars for all shells
# -----------------------------------------------------------------------------

export EDITOR=nvim
export PGDATA=/opt/homebrew/var/postgresql@17
# export JAVA_HOME=`/usr/libexec/java_home`

export STORYBOOK_DISABLE_TELEMETRY=1
export HOMEBREW_NO_ANALYTICS=1
export HOMEBREW_NO_ENV_HINTS=1
export RUBYZIP_V3_API_WARN=1 # warn on rubyzip deprecated API usage

# TODO: should probably move to commission_reporter/.envrc
export ANSIBLE_VAULT_PASSWORD_FILE=~/Applications/Scripts/vault-password

# -----------------------------------------------------------------------------
# path additions for all shells
# -----------------------------------------------------------------------------

# homebrew bin dir
[[ -z "$HOMEBREW_PREFIX" ]] && eval "$(/opt/homebrew/bin/brew shellenv)"

# homebrew postgres client bins
export PATH="$(brew --prefix postgresql@17)/bin:$PATH"

# asdf shims
. $(brew --prefix asdf)/libexec/asdf.sh
export PATH="$HOME/.asdf/shims:$PATH" # put asdf in front

# global pnpm modules
export PNPM_HOME="$HOME/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME/bin:"*) ;;
  *) export PATH="$PNPM_HOME/bin:$PATH" ;;
esac
