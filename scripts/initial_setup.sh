#!/usr/bin/env bash

## ==== BEFORE ================================================================================
##
##  Back up
##    Messages
##    iBooks
##    Dotfiles & SSH keys
##    Little Snitch   (export from app)
##    Chrome          (export from app)
##    Keychain        ~/Library/Keychains
##    Fonts           ~/Library/Fonts ~/Library/FontCollections
##    NValt notes     ~/Library/Application\ Support/Notational\ Data
##
##  Skip
##    Transmit (to restore: copy sqlite from dropbox & remove any xml)
##    Things (Things Cloud)
##    Sublime Text (license in Gmail)
##    OmniOutliner (license in 1Password)
##    GoToAssist (license in Napoli mail?)
##    Safari (bookmarks in iCloud)
##
## ==== AFTER ================================================================================
##
##  App Store
##    Coda
##    DaisyDisk
##    Disk Diet
##    Growl
##    Slack
##    YemuZip
##
##  Other stuff
##    AudioMonitor (MTCoreAudio)
##    Retina DisplayMenu -- https://dl.dropbox.com/u/87351306/RDM.tar.gz
##    -- or DisableMonitor -- https://github.com/Eun/DisableMonitor
##    Finale
##    Adobe
##    Printer
##
## ================================================================================================


formulas=(
  ansible
  coreutils
  curl
  findutils
  git
  htop-osx
  hub
  imagemagick
  openssh
  openssl
  node
  parallel
  postgresql
  readline
  rename
  sqlite
  the_silver_searcher
  tig
  trash
  tree
  unrar
  vim
  wget
  youtube-dl
  z
  zsh
  zsh-completions
)

applications=(
  1password
  alfred
  audacity
  colors
  cord
  dosbox
  dropbox
  eclipse-java
  flash
  flux
  front
  github-desktop
  gitx
  iterm2
  java
  karabiner
  libreoffice
  little-snitch
  lunchy
  macdown
  macvim
  menubar-countdown
  ngrok
  nosleep
  nvalt
  omnioutliner
  recordit
  seil
  skype
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
  font-lato
  font-lobster
  font-fira-code
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
  google-chrome     # updates too frequently
  handbrake
  heroku-toolbelt
  inkscape
  kaleidoscope      # time-limited trial
  mactex            # too big
  mysqlworkbench
  perian
  pgadmin3
  postbox           # auto-updates
  pycharm-pro
  silverlight
  the-unarchiver
  tiled
)

ruby_gems=(
  rails
  rubocop
  listen            # (for work)
)


## Install XCode tools
xcode-select --install

## Install homebrew & homebrew cask (using system ruby)
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
brew update
brew install caskroom/cask/brew-cask
export HOMEBREW_CASK_OPTS="--appdir=/Applications"
brew tap caskroom/fonts

## Install ruby (use rbenv to manage versions)
## NOTE: add eval "$(rbenv init -)" to profile once zsh is installed
brew install rbenv ruby-build
rbenv install 2.2.3

## Install libraries & tools
brew install ${formulas[@]}
##   to enable zsh:
##   1. add /usr/local/bin/zsh to /etc/shells
##   2. run chsh -s $(which zsh)
##
##   to enable zsh-completions:
##   1. add fpath=(/usr/local/share/zsh-completions $fpath) to ~/.zshrc
##   2. run rm -f ~/.zcompdump; compinit

## Install apps, fonts, quicklook plugins
brew cask install ${applications[@]}
brew cask install ${fonts[@]}
brew cask install ${quicklook_plugins[@]}

## Install gems
gem install ${ruby_gems[@]}

## Install gatling rsync plugin (for work)
vagrant plugin install vagrant-gatling-rsync

## Download Chalkboard color (for adding to iTerm manually)
wget https://raw.githubusercontent.com/mbadolato/iTerm2-Color-Schemes/master/schemes/Chalkboard.itermcolors -P ~/Downloads

## -- install node packages (eslint, eslint-babel, airbnb style, etc)
## -- install pure-prompt: https://github.com/sindresorhus/pure


## Clean everything
gem cleanup
brew cleanup
brew cask cleanup
rm -rf $(brew --cache)'/*'
