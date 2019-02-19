#!/usr/bin/env bash
set -euo pipefail

# note: run directly from Dotfiles/scripts.

formulas=(
  ansible
  coreutils
  chruby
  curl
  findutils
  ghi
  git
  htop-osx
  hub
  imagemagick
  node
  parallel
  postgresql
  readline
  rename
  ruby-install
  sqlite
  terraform
  the_silver_searcher
  tig
  trash
  tree
  unrar
  vim
  wget
  z
  zsh
  zsh-completions
)

applications=(
  1password
  alfred
  # audacity
  colors
  disablemonitor
  docker
  # dosbox
  dropbox
  # eclipse-java
  fantastical
  front
  github-desktop
  google-chrome
  iterm2
  java
  # karabiner
  # libreoffice
  little-snitch
  # lunchy
  macdown
  macvim
  # mactex
  # menubar-countdown
  # ngrok
  nosleep
  nvalt
  # omnioutliner
  postbox
  # pycharm-pro
  recordit
  rowanj-gitx
  # seil
  skype
  slack
  spotify
  steam
  sublime-text
  things
  # tiled
  transmission
  transmit
  vagrant
  virtualbox
  vlc
  xquartz
)

fonts=(
  font-fira-code
  font-input
  font-lato
  font-lobster
)

quicklook_plugins=(
  betterzipql       # show zip contents
  qlcolorcode       # colorize source code
  qlmarkdown        # markdown
  qlstephen         # files with no extension
  quicklook-csv     # csv
  quicklook-json    # json
)

ruby_gems=(
  rubocop
  listen
)

node_modules=(
  eslint
  pure-prompt
)


# Install XCode command-line tools
xcode-select --install


# Install and link dot files
devdir=~/Developer
mkdir $devdir
pushd $devdir
git clone git@github.com:johncip/Dotfiles
sh $devdir/Dotfiles/scripts/link_dotfiles.sh
popd


# Install homebrew & homebrew cask (using system ruby)
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
brew analytics off
brew update
brew tap caskroom/fonts


# Install libraries & CLI apps (+ set shell to zsh)
brew install ${formulas[@]}
echo $(which zsh) | sudo tee -a /etc/shells
chsh -s $(which zsh)


# Install applications (+ vagrant-gatling-rsync)
brew cask install ${quicklook_plugins[@]}
brew cask install ${applications[@]}
vagrant plugin install vagrant-gatling-rsync


# Install Vim plugins
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
# vim -s ./commands.vim


# Install fonts
brew cask install ${fonts[@]}
cp /Applications/Utilities/Terminal.app/Contents/Resources/Fonts/SFMono* ~/Library/Fonts


# Install gems & node modules
gem install ${ruby_gems[@]}
npm install ${node_modules[@]}


# Clean everything
gem cleanup
brew cleanup
brew cask cleanup
rm -rf $(brew --cache)'/*'
