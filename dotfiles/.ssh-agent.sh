#!/usr/bin/env bash

# Only run if in SSH session and ssh_forwarding is not turned on.
if [ -n "$SSH_CONNECTION" ] && [ -z "$SSH_AUTH_SOCK" ]; then
  SSH_ENV="$HOME/.ssh/environment"
  function start_agent {
    echo "Initialising new SSH agent..."
    /usr/bin/ssh-agent | sed 's/^echo/#echo/' > "${SSH_ENV}"
    echo succeeded
    chmod 600 "${SSH_ENV}"
    . "${SSH_ENV}" > /dev/null
    /usr/bin/ssh-add;
  }
  # Source SSH settings, if applicable
  if [ -f "${SSH_ENV}" ]; then
    . "${SSH_ENV}" > /dev/null
    ps -ef | grep ${SSH_AGENT_PID} | grep ssh-agent$ > /dev/null || {
      start_agent;
    }
  else
    start_agent;
  fi
fi
