#!/bin/bash

#{{{1 Aliases
alias irc="weechat-curses"
alias git=hub
alias tmux='TERM=screen-256color tmux' 

export webroot='/var/www/healthdata/docroot'
export website='/var/www/healthdata/docroot/sites/all/modules/'
export profiles='/var/www/healthdata/docroot/profiles/dkan/modules/dkan'

export uwebroot='/var/www/usda-nal/docroot'
export uwebsite='/var/www/usda-nal/docroot/sites/all/modules/'
export uprofiles='/var/www/usda-nal/docroot/profiles/dkan/modules/dkan'

alias profiles="cd $profiles"
alias webroot="cd $webroot"
alias website="cd $website"

alias uprofiles="cd $uprofiles"
alias uwebroot="cd $uwebroot"
alias uwebsite="cd $uwebsite"


#{{{1 Bash Colors and Prompt
LS_COLORS=$LS_COLORS:'di=00;33:ln=00;31:fi=00;32' 
export LS_COLORS

RED="\[\033[0;31m\]"
YELLOW="\[\033[0;33m\]"
GREEN="\[\033[0;32m\]"
BLUE="\[\033[0;36m\]"
WHITE="\[\033[0;37m\]"

# Makes prompt wrap to next line.
COLUMNS=250
PS1="$BLUE\u$RED\$(date +%H:%M)[\w]\n($GREEN\W$RED)$YELLOW\$(__git_ps1 '(%s)')$GREEN\$$WHITE"

# Mac Colors.
export CLICOLOR=1
export LSCOLORS=GxFxCxDxBxegedabagaced

#{{{1 Extras
set -o vi

# Auto ssh-agent.
if [ -e ~/.ssh-agent.sh ]; then
  source ~/.ssh-agent.sh
fi

# Conditionally add paths to $PATH
composer_bin=~/.composer/vendor/bin
if [ -d $composer_bin ]; then
  case ":${PATH:=$composer_bin}:" in
    *:$composer_bin:*)  ;;
    *) export PATH="$composer_bin:$PATH"  ;;
  esac
fi

home_bin=~/bin
if [ -d $home_bin ]; then
  case ":${PATH:=$home_bin}:" in
    *:$home_bin:*)  ;;
    *) export PATH="$home_bin:$PATH"  ;;
  esac
fi


