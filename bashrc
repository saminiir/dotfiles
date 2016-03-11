# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions

function ssh_init {
  sshadd="ssh-add -t 3600"
  ssh-add -l &>/dev/null
  ret="$?"
  if [ $ret == 2 ]; then
    test -r ~/.ssh-agent && \
      eval "$(<~/.ssh-agent)" >/dev/null
  
    ssh-add -l &>/dev/null
    if [ "$?" == 2 ]; then
      (umask 066; ssh-agent > ~/.ssh-agent)
      eval "$(<~/.ssh-agent)" >/dev/null
      $sshadd
    fi
  fi
  if [ $ret == 1 ]; then
    $sshadd
  fi
}
