#
# sh/ksh initialization


# -- for single-user mode --
export TERM=${TERM:-wsvt25}
export USER=${USER:-root}
export HOME=${HOME:-/root}


# -- path --
export PATH=/sbin:/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/usr/games:/usr/X11R6/bin:$HOME/bin


# -- locale --


# -- BLOCKSIZE env var --
export BLOCKSIZE=1k


# -- EDITOR, VISUAL env vars --
if [ -x /usr/local/bin/nano ]; then
  export EDITOR=nano
elif [ -x /usr/bin/vi ]; then
  export EDITOR=vi
fi
export VISUAL="${EDITOR}"


# -- PAGER env var --
export PAGER=less


# -- less env vars --
export LESS="-QR"
export LESSHISTFILE="-"


# -- set ENV to a file invoked each time sh is started --
export ENV=$HOME/.shrc
