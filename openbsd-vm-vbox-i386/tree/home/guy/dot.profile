
# -- BLOCKSIZE env var --
export BLOCKSIZE=1k


# -- locale --


# -- EDITOR, VISUAL env vars --
if [ -x /usr/local/bin/nano ]; then
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
