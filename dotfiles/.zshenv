export STORYBOOK_DISABLE_TELEMETRY=1
export HOMEBREW_NO_ANALYTICS=1
export HOMEBREW_NO_ENV_HINTS=1
export PERCY_TOKEN=***REMOVED***
export EDITOR=nvim
export ANSIBLE_VAULT_PASSWORD_FILE=~/Applications/Scripts/vault-password
export PGDATA=/opt/homebrew/var/postgresql@17
# export JAVA_HOME=`/usr/libexec/java_home`

# add homebrew to path
eval "$(/opt/homebrew/bin/brew shellenv)"

# install asdf shims
. $(brew --prefix asdf)/libexec/asdf.sh

# add postgres client bin
export PATH="$(brew --prefix postgresql@17)/bin:$PATH"

# warn on rubyzip deprecated API usage
export RUBYZIP_V3_API_WARN=1
