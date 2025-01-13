export HOMEBREW_NO_ANALYTICS=1
export PERCY_TOKEN=web_fd2e8203c3f09e52729837c4119b1f25495c642b8a374b45f14f0ee96d5a3516
export EDITOR=nvim
# export JAVA_HOME=`/usr/libexec/java_home`
export ANSIBLE_VAULT_PASSWORD_FILE=~/Applications/Scripts/vault-password
export PGDATA=/opt/homebrew/var/postgresql@17

# add homebrew to path
eval "$(/opt/homebrew/bin/brew shellenv)"

# install asdf shims
. $(brew --prefix asdf)/libexec/asdf.sh
