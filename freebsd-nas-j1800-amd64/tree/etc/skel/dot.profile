#
# .profile - Bourne Shell startup script for login shells
#
# see also sh(1), environ(7).


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


# -- set ENV to a file invoked each time sh is started interactively. --
export ENV=$HOME/.shrc
