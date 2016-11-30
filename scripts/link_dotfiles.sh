#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

REPO_DIR="$HOME/Developer/Dotfiles"

dotfiles=(
  aliases
  gemrc
  gitconfig
  inputrc
  railsrc
  rspec
  vimrc
  zshrc
)

for dotfile in ${dotfiles[@]}
do
    ln -s "$REPO_DIR/$dotfile" "$HOME/.$dotfile"
done
