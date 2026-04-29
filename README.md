# johncip's dotfiles

## Overview

My work mostly involves writing Ruby and JS/TS, on a Mac, with vim. So the most important things are my zsh & neovim configs.

I don't use oh-my-zsh, or vim frameworks, etc. I do use vim-plug.


Path management / big things that zsh needs to know about:

* `asdf` and `dotenv` for managing per-project dev environments
* homebrew for mac package management


## Vim keybindings

These are probably my most important keybindings. I recommend them.

* `<Up>` to fuzzy search repo
* `<Down>` to fuzzy only files modified in git working tree
* `<Left>` to cycle through open panes
* `<Right>` to cycle backwards throw open panes
* `<Tab>` to cycle through open buffers
* `<Shift-Tab>` to cycle through open buffers
* `jk` to escape insert mode


## Functions

I have some useful things in `.functions` that get sourced by `.zshrc`.

The one I use most is `nuke-merged-branch`, which assumes a local branch has been merged on a remote repository (e.g. via PR), and deletes both the local & remote & remote branches, after checking out and updating main.


## GNU Stow

This repo is structured to be used with GNU Stow, with the real files under `dotfiles/`.

```bash
cd $HOME/Developer

stow \
  --simulate \
  --verbose \
  --target=$HOME \
  --dir=$HOME/Developer/Dotfiles \
  dotfiles
```

(and then run without --simulate)


## Secrets

`.stow-local-ignore` is set up to ignore a couple of places I have secrets.

Project-local secrets live in the projects and get picked up by `dotenv`.
