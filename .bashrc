# ~/.bashrc: executed by bash(1) for non-login shells.

# exit if shell in non-interactive
[[ $- != *i* ]] && return

export PS1='\u@\h:\w\$ '
umask 027

# Produce colorized PS1 wit indication of last command exit code
__prompt_command() {
    local EXIT="$?"             # This needs to be first
    PS1=""

    local clReset='\[\e[0m\]'
    local clRed='\[\e[0;31m\]'
    local clGreen='\[\e[0;32m\]'
    local clLightGreen='\[\e[01;32m\]'
    local clYellow='\[\e[1;33m\]'
    local clBlue='\[\e[1;34m\]'
    local clPur='\[\e[0;35m\]'

    # red color for root user
    if [ "$USER" == "root" ]; then
        PS1="${clRed}\u${clReset}"
        local END='#'
    else
        PS1="${clLightGreen}\u${clReset}"
        local END='$'
    fi

    PS1+="@${clLightGreen}\h${clReset}:${clBlue}\w${clReset}"

    if [ $EXIT != 0 ]; then
        PS1+="(${clRed}$EXIT${clReset})$END "
    else
        PS1+="$END "
    fi
}

# Executed as command prior to issuing each primary prompt
PROMPT_COMMAND=__prompt_command

# Bash completion
[ -f /etc/bash_completion ] && source /etc/bash_completion
# AWS cli completion
which aws_completer &> /dev/null && complete -C aws_completer aws

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

# Less onput/output preprocess to display some binary formats
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
alias pinggw='ping $(ip route show 0.0.0.0/0 |  cut -d" " -f3 )'

