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
  zshenv
  zshrc
)

for dotfile in ${dotfiles[@]}
do
    ln -f -s "$REPO_DIR/$dotfile" "$HOME/.$dotfile"
done


ln -f -s "$REPO_DIR/vimrc" "$HOME/.config/nvim/init.vim"

mkdir -p "$HOME/.config/yt-dlp"
ln -f -s "$REPO_DIR/yt-dlp" "$HOME/.config/yt-dlp/config"
