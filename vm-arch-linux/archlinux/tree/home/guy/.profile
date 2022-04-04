
# -- locale --
export LANG=en_IL.UTF-8
export LC_COLLATE=en_IL.UTF-8
export LC_CTYPE=en_IL.UTF-8
export LC_MESSAGES=en_IL.UTF-8
export LC_MONETARY=en_IL.UTF-8
export LC_NUMERIC=en_IL.UTF-8
export LC_TIME=en_IL.UTF-8
export LC_PAPER=en_IL.UTF-8
export LC_NAME=en_IL.UTF-8
export LC_ADDRESS=en_IL.UTF-8
export LC_TELEPHONE=en_IL.UTF-8
export LC_MEASUREMENT=en_IL.UTF-8
export LC_IDENTIFICATION=C


# -- EDITOR, VISUAL env vars --
export EDITOR=nano
export VISUAL="${EDITOR}"


# -- PAGER env var --
export PAGER=less


# -- less env vars --
export LESS="-QR"
export LESSHISTFILE="-"


# -- set XDG env vars --
export XDG_CONFIG_HOME=$HOME/config
export XDG_CACHE_HOME=/var/xdg-cache/"$USER"


# -- private tmp dir --
install -d -o "$USER" -g "$USER" -m 700 /tmp/"$USER"
