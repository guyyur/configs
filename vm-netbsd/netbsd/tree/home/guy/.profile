#
# This is the default .profile file.
# Users are expected to edit it to meet their own needs.
#
# The commands in this file are executed when an sh user first
# logs in.
#
# See sh(1) for details.
#


# -- path --
export PATH=/sbin:/bin:/usr/pkg/sbin:/usr/pkg/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/usr/games:/usr/X11R7/bin:$HOME/bin


# -- locale --
export MM_CHARSET=UTF-8
export LANG=en_US.UTF-8
export LC_COLLATE=en_US.UTF-8
export LC_CTYPE=en_US.UTF-8
export LC_MESSAGES=en_US.UTF-8
export LC_MONETARY=he_IL.UTF-8
export LC_NUMERIC=en_US.UTF-8
export LC_TIME=en_GB.UTF-8


# -- BLOCKSIZE env var --
export BLOCKSIZE=1k


# -- EDITOR, VISUAL env vars --
if [ -x /usr/pkg/bin/nano ]; then
  export EDITOR=nano
else
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


# -- set XDG env vars --
export XDG_CONFIG_HOME=$HOME/config
export XDG_CACHE_HOME=/var/xdg-cache/"$USER"


# -- private tmp dir --
install -d -o "$USER" -g "$USER" -m 700 /tmp/"$USER"


# -- run zsh if exists --
if [ -x /usr/pkg/bin/zsh ]; then
  export SHELL=/usr/pkg/bin/zsh
  case "$-" in
    *i*) exec $SHELL ;;
  esac
fi
