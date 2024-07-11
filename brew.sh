#!/usr/bin/env bash

# Install command-line tools using Homebrew.

# Make sure we’re using the latest Homebrew.
brew update

# Upgrade any already-installed formulae.
brew upgrade

# Save Homebrew’s installed location.
BREW_PREFIX=$(brew --prefix)

# Install GNU core utilities (those that come with macOS are outdated).
# Don’t forget to add `$(brew --prefix coreutils)/libexec/gnubin` to `$PATH`.
brew install coreutils
ln -s "${BREW_PREFIX}/bin/gsha256sum" "${BREW_PREFIX}/bin/sha256sum"

# Install `wget`.
brew install wget 

# Install usefull binaries
brew install htop
brew install nano
brew install nanorc
brew install neofetch
brew install pipx
brew install starship
brew install tree
brew install wireguard-tools
brew install zsh-autosuggestions
brew install zsh-syntax-highlighting

# Install usefull apps via brew cask
brew install --cask font-fira-code-nerd-font # nerd font for terminal and text editiors
# brew install --cask 1password
# brew install --cask alfred
# brew install --cask bettertouchtool
brew install --cask discord
brew install --cask docker
# brew install --cask firefox
brew install --cask iterm2
# brew install --cask microsoft-edge
# brew install --cask microsoft-excel
# brew install --cask microsoft-word
brew install --cask obsidian
brew install --cask rectangle
brew install --cask telegram
brew install --cask visual-studio-code
brew install --cask whatsapp
# brew install --cask whisky
brew install --cask spotify
brew install --cask alfred