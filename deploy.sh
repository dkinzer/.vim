#!/bin/bash

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
  git pull origin master
fi

log "Upate the submodules."
git submodule init
git submodule update

log "Link dotfiles"
for file in $(find ./dotfiles -type f); do
  ln -fs ~/.vim/dotfiles/$file ~/$file
done;
