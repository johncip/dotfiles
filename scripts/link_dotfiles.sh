#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

REPO_DIR="$HOME/Developer/Dotfiles"

dotfiles=(
  aliases
  functions
  gemrc
  gitconfig
  inputrc
  railsrc
  rspec
  vimrc
  zprofile
  zshrc
)

for dotfile in ${dotfiles[@]}
do
    ln -f -s "$REPO_DIR/$dotfile" "$HOME/.$dotfile"
done
