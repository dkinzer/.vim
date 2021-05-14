#!/bin/bash

if type brew &>/dev/null; then
  if [[ -f $(brew --prefix)/etc/profile.d/bash_completion.sh ]];
  then
    source "$(brew --prefix)/etc/profile.d/bash_completion.sh"
  fi
fi

#{{{1 Aliases
alias irc="weechat-curses"
alias git=hub
alias tmux='TERM=screen-256color tmux' 
alias containerizeme='docker-machine start default; eval "$(docker-machine env default)"; docker-machine-nfs default --shared-folder=$HOME/docker-share --force'
alias lasso='DOMAIN=devkinzer.test roper lasso -b'
alias release='DOMAIN=devkinzer.test roper release -b'
if [ $(which hub) ]; then alias git=hub; fi
export AHOY_CMD_PROXY=DOCKER
export EDITOR=vim
base=~/docker-share/sites


projects=( healthdata usda-nal/master data_starter_private ok_data lky )
for project in ${projects[@]}
do
  c=${project:0:1}
  export ${c}root="/var/www/$project"
  export ${c}webroot="$base/$project"
  export ${c}website="$base/$project/docroot/sites/all/modules"
  export ${c}profiles="``/$project/dkan"

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
PS1="$BLUE\u$RED \$(date +%H:%M) [\w]\n($GREEN\W$RED) $YELLOW\$(__git_ps1 '(%s)')$GREEN > $WHITE"

# Mac Colors.
export CLICOLOR=1
export LSCOLORS=GxFxCxDxBxegedabagaced

#{{{1 Extras
set -o vi

#{{{2 Auto ssh-agent.
if [ -e ~/.ssh-agent.sh ]; then
  source ~/.ssh-agent.sh
fi

#{{{2 Conditionally add paths to $PATH
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

#{{{2 rbenv
export PATH="$HOME/.rbenv/bin:$PATH"

if command -v rbenv
then
  hash rbenv && eval "$(rbenv init -)"
  export PATH="$HOME/.rbenv/plugins/ruby-build/bin:$PATH"
fi

#{{{2 Go lang
if command -v go
then
  eval `go env | grep GOPATH` &> /dev/null
  export PATH=$PATH:$GOPATH/bin
fi

#{{{ Wee chat fortunes
if [ -d ~/projects/cowsay_weechat_fortune ]; then
  pushd ~/projects/cowsay_weechat_fortune > /dev/null
  rake
  popd > /dev/null
fi

export LT_HOME=/Applications/LightTable

# {{{1 GPG
export GPG_TTY=$(tty)
use_gpg_agent() {
  gpgconf --kill gpg-agent 
	eval $( gpg-agent --daemon )
}

