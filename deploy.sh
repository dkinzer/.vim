#!/bin/bash

set -eo pipefail

function log {
  echo -e "\e[1;31m>> \e[1;34m$1\e[0m"
}

log "Clone or update the .vim project."
vim_conf_source='https://github.com/dkinzer/.vim.git'
if [ ! -d "$HOME/.vim" ];
then
  git clone $vim_conf_source '.vim';
  cd ~/.vim
else 
  cd ~/.vim
  git pull origin main
fi

log "Upate the submodules."
git submodule init
git submodule update

log "Link dotfiles"
for file in $(find ./dotfiles -type f -exec basename {} \;); do
  ln -fs ~/.vim/dotfiles/$file ~/$file
done;

log "Link commands"
mkdir -p ~/bin
for file in $(find ./bin -type f -exec basename {} \;); do
  ln -fs ~/.vim/bin/$file ~/bin/$file
done;
