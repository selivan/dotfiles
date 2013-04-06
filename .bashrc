# ~/.bashrc: executed by bash(1) for non-login shells.

# exit if shell in non-interactive
[[ $- != *i* ]] && return

export PS1='\h:\w\$ '
umask 022

# Bash completion
[ -f /etc/bash_completion ] && . /etc/bash_completion

# Errors autocorrection
shopt -s cdspell

export EDITOR=vi

# Less onput/output preprocess to display soem binary formats
[ -f "$(which lesspipe)" ] && eval "$(lesspipe)"

# Correct screen and tmux behavior with ssh-agent
parent="$(ps -o comm --no-headers $PPID)"

# Keep ssh variables for screen/tmux sessions
case $parent in
sshd)
        keep_vars="SSH_CLIENT SSH_TTY SSH_AUTH_SOCK SSH_CONNECTION DISPLAY XAUTHORITY"
        touch $HOME/.ssh/keep_vars
        chmod 600 $HOME/.ssh/keep_vars
        for i in $keep_vars; do
                 (eval echo export $i=\\\'\$$i\\\')
        done > $HOME/.ssh/keep_vars
;;
screen|tmux)
        source $HOME/.ssh/keep_vars
;;
esac
# This command must be run from shell within detached and re-attached screen session
# to interact with ssh-agent properly
alias fixssh="source $HOME/.ssh/keep_vars"

# Colorize ls
[ -f "$(which dircolors)" ] && eval "$(dircolors)"
alias ls='ls --color=auto'

# Aliases
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
alias e=$EDITOR
alias l=less
alias df='df -h'
alias s='screen -d -RR'
alias ssh='source $HOME/.ssh/keep_vars; ssh'
alias scp='source $HOME/.ssh/keep_vars; scp'
alias whereami='hostname -f'

