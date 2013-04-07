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

log "Link the .vimrc"
ln -fs ~/.vim/.vimrc ~/.vimrc

log "Upate the submodules."
git submodule init
git submodule update
