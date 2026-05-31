#!/bin/bash

export EDITOR=vim
PROD_CLUSTER=prod-library0-fqdn
DEV_CLUSTER=dev-library0-fqdn


#{{{1 Aliases
alias irc="weechat-curses"
alias tmux='TERM=screen-256color tmux' 
alias containerizeme='docker-machine start default; eval "$(docker-machine env default)"; docker-machine-nfs default --shared-folder=$HOME/docker-share --force'
alias lasso='DOMAIN=devkinzer.test roper lasso -b'
alias release='DOMAIN=devkinzer.test roper release -b'
if command -v hub >/dev/null 2>&1; then
  alias git=hub
fi
alias dev-cluster="kubectl config use $DEV_CLUSTER"
alias prod-cluster="kubectl config use $PROD_CLUSTER"

alias prod0='kubectl config use prod-library0-fqdn'
alias prod1='kubectl config use prod-library1-fqdn'

alias dev0='kubectl config use dev-library0-fqdn'
alias dev1='kubectl config use dev-library1-fqdn'

alias namespace="kubectl config set-context --current --namespace"
alias namespaces="kubectl get namespaces --no-headers -o custom-columns=:.metadata.name | grep '\(\-prod\|\-qa\)'"

alias describe="kubectl describe"
alias pods="kubectl get pods"
alias contexts="kubectl config get-contexts"
alias cronjobs="kubectl get cronjobs"
alias pvc="kubectl get pvc"
alias kcb='kubectl cnpg backup --method=plugin --plugin-name=barman-cloud.cloudnative-pg.io'
alias rails='bundle exec rails'
alias rspec='bundle exec rspec'
alias spec=rspec
alias secrets='source ~/.secrets'

#{{{1 Bash Completions
source_once() {
  local file="$1"
  local var="${2:-_SOURCED_$(echo "$file" | tr '/.-' '___')}"

  if [[ -z "${!var:-}" && -f "$file" ]]; then
    source "$file"
    printf -v "$var" 1
  fi
}

if command -v brew >/dev/null 2>&1; then
  brew_prefix="$(brew --prefix)"

  if [[ -f "$brew_prefix/etc/profile.d/bash_completion.sh" ]]; then
    source_once "$brew_prefix/etc/profile.d/bash_completion.sh"
  fi

  git_prefix="$(brew --prefix git 2>/dev/null)"

  if [[ -n "$git_prefix" && -f "$git_prefix/etc/bash_completion.d/git-prompt.sh" ]]; then
    source_once "$git_prefix/etc/bash_completion.d/git-prompt.sh"
  fi

  if [[ -n "$git_prefix" && -f "$git_prefix/etc/bash_completion.d/git-completion.bash" ]]; then
    source_once "$git_prefix/etc/bash_completion.d/git-completion.bash"
  fi
fi

if command -v brew >/dev/null 2>&1; then
  brew_prefix="$(brew --prefix)"

  if [[ -f "$brew_prefix/etc/profile.d/bash_completion.sh" ]]; then
    source_once "$brew_prefix/etc/profile.d/bash_completion.sh"
  fi

  git_prefix="$(brew --prefix git 2>/dev/null)"

  if [[ -n "$git_prefix" && -f "$git_prefix/etc/bash_completion.d/git-prompt.sh" ]]; then
    source_once "$git_prefix/etc/bash_completion.d/git-prompt.sh"
  fi

  if [[ -n "$git_prefix" && -f "$git_prefix/etc/bash_completion.d/git-completion.bash" ]]; then
    source_once "$git_prefix/etc/bash_completion.d/git-completion.bash"
  fi
fi


if command -v velero >/dev/null 2>&1 && [[ -z "${_VELERO_COMPLETION_LOADED:-}" ]]; then
  source <(velero completion bash)
  _VELERO_COMPLETION_LOADED=1
fi

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

if type __git_ps1 >/dev/null 2>&1; then
  GIT_PROMPT="\$(__git_ps1 '(%s)')"
else
  GIT_PROMPT=""
fi
PS1="$BLUE\u$RED \$(date +%H:%M) [\w]\n($GREEN\W$RED) $YELLOW$GIT_PROMPT$GREEN > $WHITE"

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
path_prepend() {
  [ -d "$1" ] || return

  case ":$PATH:" in
    *":$1:"*) ;;
    *) export PATH="$1:$PATH" ;;
  esac
}

path_prepend "${KREW_ROOT:-$HOME/.krew}/bin"
path_prepend "/opt/homebrew/sbin"
path_prepend "/opt/homebrew/bin"
path_prepend ~/bin

if command -v rbenv >/dev/null 2>&1 && [[ -z "${_RBENV_LOADED:-}" ]]; then
  path_prepend "$HOME/.rbenv/bin"
  path_prepend "$HOME/.rbenv/plugins/ruby-build/bin"
  eval "$(rbenv init -)"
  _RBENV_LOADED=1
fi

if command -v go >/dev/null 2>&1; then
  eval "$(go env | grep GOPATH)" >/dev/null 2>&1
  path_prepend "$GOPATH/bin"
fi

export LT_HOME=/Applications/LightTable

# {{{1 GPG
export GPG_TTY=$(tty)
use_gpg_agent() {
  gpgconf --kill gpg-agent 
	eval $( gpg-agent --daemon )
}

#{{{ Wee chat fortunes
if [ -d ~/projects/cowsay_weechat_fortune ] && [[ -z "${_FORTUNE_LOADED:-}" ]]; then
  pushd ~/projects/cowsay_weechat_fortune > /dev/null
  rake
  popd > /dev/null
  _FORTUNE_LOADED=1
fi

