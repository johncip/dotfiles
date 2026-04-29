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

# add homebrew to path
[[ -z "$HOMEBREW_PREFIX" ]] && eval "$(/opt/homebrew/bin/brew shellenv)"

# install asdf shims
. $(brew --prefix asdf)/libexec/asdf.sh

# add postgres client bin
export PATH="$(brew --prefix postgresql@17)/bin:$PATH"
