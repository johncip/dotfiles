#!/usr/bin/env bash
set -euo pipefail

# note: run directly from Dotfiles/scripts.

# TODO: go through and see what I have installed now
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

casks=(
  1password6
  audacity
  # avibrazil-rdm
  avidemux
  # balenaetcher
  cyberduck
  discord
  # docker
  dosbox-x
  dropbox
  # fantastical
  flux
  fork
  github
  github-desktop
  google-chrome
  handbrake
  iina
  iterm2
  macdown
  # microsoft-teams
  nvalt
  # obs
  # omnioutliner
  # openemu
  postico
  qlvideo
  # raspberry-pi-imager
  # recordit
  # scummvm
  serviio
  spotify
  steam
  sublime-text
  switchresx
  teamviewer
  things
  # tigervnc-viewer
  transmission
  # ultimaker-cura
  # vagrant
  vimr
  virtualbox
  visual-studio-code
  # vlc
  webpquicklook
  xquartz
  zoom
)

fonts=(
  font-fira-code
  font-input
  font-lato
  font-fantasque-sans-mono
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


# Install casks
brew cask install ${quicklook_plugins[@]}
brew cask install ${casks[@]}
# vagrant plugin install vagrant-gatling-rsync


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
