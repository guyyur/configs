
# -- prompt --
PS1='[\u@\h:\w]\$ '


# -- history --
unset HISTFILE
export HISTCONTROL=erasedups


# -- builtins --
enable -n kill


# -- aliases --
alias ls='ls --color=auto'
alias la='ls -A'
alias lf='ls -F'
alias ll='ls -l'
alias cp='cp -i'
alias mv='mv -i'
alias grep='grep --color=auto'
