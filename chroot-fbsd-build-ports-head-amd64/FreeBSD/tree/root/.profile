
# .profile - Bourne Shell startup script for login shells
#
# see also sh(1), environ(7).


# -- for single-user mode --
export TERM=${TERM:-xterm}
export USER=${USER:-root}
export HOME=${HOME:-/root}


# -- path --
export PATH=/sbin:/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:$HOME/bin


# -- locale --
export MM_CHARSET=UTF-8
export LANG=en_US.UTF-8
export LC_COLLATE=en_US.UTF-8
export LC_CTYPE=en_US.UTF-8
export LC_MESSAGES=en_US.UTF-8
export LC_MONETARY=he_IL.UTF-8
export LC_NUMERIC=en_US.UTF-8
export LC_TIME=en_GB.UTF-8


# -- block size --
export BLOCKSIZE=K


# -- ncurses --
export NCURSES_NO_UTF8_ACS=1


# -- EDITOR, VISUAL env vars --
if [ -x /usr/local/bin/nano ]; then
  export EDITOR=nano
elif [ -x /usr/bin/ee ]; then
  export EDITOR=ee
else
  export EDITOR=/rescue/vi
fi
export VISUAL="${EDITOR}"


# -- ls env vars --
export LSCOLORS=ExFxGxdxCxDxDxhbadacad
export CLICOLOR=1


# -- PAGER env var --
export PAGER=less


# -- less env vars --
export LESS="-QR"
export LESSHISTFILE="-"


# -- set ENV to a file invoked each time sh is started interactively --
export ENV=$HOME/.shrc
