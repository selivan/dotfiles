# ~/.bashrc: executed by bash(1) for non-login shells.

# exit if shell in non-interactive
[[ $- != *i* ]] && return

export PS1='\u@\h:\w\$ '
umask 027

# Bash completion
if [ -f /etc/bash_completion ]; then
   . /etc/bash_completion
   export PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi

# Errors autocorrection
shopt -s cdspell
# Append to the Bash history file, rather than overwriting it
shopt -s histappend
# `**/qux` will enter `./foo/bar/baz/qux`
shopt -s autocd
# Recursive globbing, e.g. `echo **/*.txt`
shopt -s globstar

# bash history: ignore duplicates and commands starting from space
HISTCONTROL=ignorespace

# Less onput/output preprocess to display soem binary formats
[ -f "$(which lesspipe)" ] && eval "$(lesspipe)"

# Colorize ls
[ -f "$(which dircolors)" ] && eval "$(dircolors)"
alias ls='ls --color=auto'

# SSH correct behaviour when attaching to detached tmux/screen
if [ -n "$SSH_AUTH_SOCK" -a "$SSH_AUTH_SOCK" != "$HOME/.ssh/auth_sock" ]; then
        ln -sf $SSH_AUTH_SOCK $HOME/.ssh/auth_sock
        export SSH_AUTH_SOCK=$HOME/.ssh/auth_sock
fi

# Rename tmux window when connecting to remote host
ssh() {
# ${@: -1} - last argument (bash)
which tmux >/dev/null && tmux has-session 2>/dev/null && tmux rename-window ${@: -1}
command ssh "$@"
which tmux >/dev/null && tmux has-session 2>/dev/null && tmux rename-window bash
}

# Local config. May be usable:
# Reset read-only TMOUT variable
#alias fuckoff='exec sh -c "unset TMOUT; exec bash"'
# Disable IXON control sequence (Freezing termianl with Control-S)
#stty -ixon
# Disable screen blanking on text console
#setterm -blank 0 -powersave off -powerdown 0
# Disable screen blanking in X
#xset s off
[ -f ~/.bashrc.local ] && source ~/.bashrc.local

which vim > /dev/null && export EDITOR=vim

# URL encode/decode
alias urldecode='python -c "import sys, urllib as ul; print ul.unquote_plus(sys.argv[1])"'

alias urlencode='python -c "import sys, urllib as ul; print ul.quote_plus(sys.argv[1])"'

# Aliases
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
alias ll='ls --color=auto -l'
alias df='df -h'
alias w1='watch -n 1'
