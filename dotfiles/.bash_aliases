#!/bin/bash

#{{{1 Aliases
alias irc="weechat-curses"
alias git=hub
alias tmux='TERM=screen-256color tmux' 

projects=( healthdata usda-nal/master data_starter )
for project in ${projects[@]}
do
  c=${project:0:1}
  export ${c}root="/var/www/$project"
  export ${c}webroot="/var/www/$project/docroot"
  export ${c}website="/var/www/$project/docroot/sites/all/modules"
  export ${c}profiles="/var/www/$project/docroot/profiles/dkan/modules/dkan"

  alias ${c}root="cd \$${c}root"
  alias ${c}profiles="cd \$${c}profiles"
  alias ${c}webroot="cd \$${c}webroot"
  alias ${c}website="cd \$${c}website"
done

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


