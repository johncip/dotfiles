#!/usr/bin/env bash
set -euo pipefail

# note: run directly from Dotfiles/scripts.


# Install XCode command-line tools
xcode-select --install


# Install homebrew & homebrew cask (using system ruby)
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
brew analytics off


# Install app store apps
brew install mas
app_store_ids=(
  824183456  # affinity photo
  937984704  # amphetamine
  411643860  # daisydisk
  668208984  # giphy capture
  462058435  # microsoft excel
  462054704  # microsoft word
  1123195469 # slomo
  822514576  # sonicwall mobile connect
  904280696  # things 3
  409203825  # numbers
  409201541  # pages
)
mas install ${app_store_ids[@]}


# Install development casks
dev_casks=(
  dbvisualizer
  fork
  neovide
  visual-studio-code
  wezterm
)
brew install ${dev_casks[@]}


# Install fonts
font_casks=(
  font-fantasque-sans-mono
  font-fira-code
  font-input
  font-jetbrains-mono
  font-lato
)
brew install --cask ${font_casks[@]}
cp /System/Applications/Utilities/Terminal.app/Contents/Resources/Fonts/SF-Mono-*.otf ~/Library/Fonts


# Install misc casks
casks=(
  cyberduck
  discord
  dropbox
  elpass
  firefox
  google-chrome
  handbrake
  iina
  microsoft-teams
  nordvpn
  raindropio
  spotify
  soundsource
  steam
  sublime-text
  teamviewer
  transmission
  whatsapp
  xquartz
)
brew install --cask ${casks[@]}


# Install formulas
formulas=(
  ansible
  bat
  fzf
  gh
  git
  mailhog
  neovim
  redis
  rename
  the_silver_searcher
  tree
  universal-ctags
  yt-dlp ffmpeg
  z
)
brew install ${formulas[@]}


# Install asdf
asdf_formulas=(
  coreutils
  git
  gawk
  gpg
  asdf
)
brew install ${asdf_formulas[@]}
asdf plugin add nodejs https://github.com/asdf-vm/asdf-nodejs.git
asdf plugin add ruby https://github.com/asdf-vm/asdf-ruby.git
asdf plugin add python https://github.com/danhper/asdf-python.git
asdf install nodejs latest
asdf global nodejs latest


# Install pure prompt
asdf exec npm install -g pure-prompt


# Install zsh & change shell
brew install zsh zsh-completions
echo $(which zsh) | sudo tee -a /etc/shells
chsh -s $(which zsh)


# Restore dotfiles
devdir=$HOME/Developer
mkdir $devdir
pushd $devdir
git clone git@github.com:johncip/dotfiles
stow --verbose --target=/Users/john --dir=$devdir/dotfiles dotfiles # or add --simulate
popd


# Install plug.vim
curl -fLo /Users/john/.config/nvim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
vim -s ./commands.vim # or open vim and :PlugInstall :PlugClean


# Install ODBC driver for ibm db2 & odbc
brew tap ibm/iaccess https://public.dhe.ibm.com/software/ibmi/products/odbc/macos/tap/
brew install ibm-iaccess
brew install unixodbc
bundle config --global build.ruby-odbc --with-odbc-dir=$(brew --prefix unixodbc)


# Install postgresql
brew install postgresql@17
brew services restart postgresql@17
bundle config --global build.pg --with-pg-config=$(brew --prefix postgresql@17)/bin/pg_config
