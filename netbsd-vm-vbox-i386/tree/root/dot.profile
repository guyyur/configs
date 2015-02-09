
# -- for single-user mode --
export TERM=${TERM:-wsvt25}
export USER=${USER:-root}
export HOME=${HOME:-/root}
export PATH=/sbin:/bin:/usr/pkg/sbin:/usr/pkg/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/usr/games:/usr/X11R7/bin:$HOME/bin


# -- BLOCKSIZE env var --
export BLOCKSIZE=1k


# -- locale --
export MM_CHARSET=UTF-8
export LANG=en_US.UTF-8
export LC_COLLATE=en_US.UTF-8
export LC_CTYPE=en_US.UTF-8
export LC_MESSAGES=en_US.UTF-8
export LC_MONETARY=he_IL.UTF-8
export LC_NUMERIC=en_US.UTF-8
export LC_TIME=en_GB.UTF-8


# -- EDITOR, VISUAL env vars --
if [ -x /usr/pkg/bin/nano ]; then
  export EDITOR=nano
elif [ -x /usr/bin/vi ]; then
  export EDITOR=vi
else
  export EDITOR=/rescue/vi
fi
export VISUAL="${EDITOR}"


# -- PAGER env var --
export PAGER=less


# -- less env vars --
export LESS="-QR"
export LESSHISTFILE="-"


# -- set ENV to a file invoked each time sh is started --
export ENV=$HOME/.shrc
