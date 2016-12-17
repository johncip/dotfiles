#!/usr/bin/env bash

formulas=(
  ansible
  coreutils
  chruby
  curl
  findutils
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
# cord
  docker
# dosbox
  dropbox
# eclipse-java
  fantastical
# flash
  flux
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
# menubar-countdown
# ngrok
  nosleep
  nvalt
# omnioutliner
  postbox
  recordit
  rowanj-gitx
# seil
  skype
  slack
  spotify
  steam
  sublime-text
  things
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

# Casks to keep in mind but not auto-install
benched=(
  avidemux
  broomstick
  ccleaner
  ffmpegx
  file-juicer
  handbrake
  heroku-toolbelt
  inkscape
  kaleidoscope      # time-limited trial
  mactex            # too big
  mysqlworkbench
  perian
  pgadmin3
  pycharm-pro
  silverlight
  the-unarchiver
  tiled
)

ruby_gems=(
  rubocop
  listen
)


## Install XCode tools
xcode-select --install

## Install homebrew & homebrew cask (using system ruby)
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
brew analytics off
brew update
brew tap caskroom/fonts

## Install libraries & tools
brew install ${formulas[@]}
##   to enable zsh:
##   1. add /usr/local/bin/zsh to /etc/shells
##   2. run chsh -s $(which zsh)

## Install apps, fonts, quicklook plugins
brew cask install ${applications[@]}
brew cask install ${fonts[@]}
cp /Applications/Utilities/Terminal.app/Contents/Resources/Fonts/SFMono* ~/Library/Fonts
brew cask install ${quicklook_plugins[@]}

## Install gems
gem install ${ruby_gems[@]}

## Install gatling rsync plugin (for work)
vagrant plugin install vagrant-gatling-rsync

npm install -g eslint
npm install -g pure-prompt


## Clean everything
gem cleanup
brew cleanup
brew cask cleanup
rm -rf $(brew --cache)'/*'
