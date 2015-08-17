#!/bin/bash

#{{{1 Aliases
alias irc="weechat-curses"
alias git=hub
alias tmux='TERM=screen-256color tmux' 


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

#{{{1 Extras
set -o vi



