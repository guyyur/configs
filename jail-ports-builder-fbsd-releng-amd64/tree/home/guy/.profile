# .profile - Bourne Shell startup script for login shells

# -- set ENV to a file invoked each time sh is started interactively --
export ENV=$HOME/.shrc

# -- path --
export PATH=/sbin:/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:$HOME/bin

# -- editors --
if [ -x /usr/local/bin/nano ]; then
  export EDITOR=nano
else
  export EDITOR=vi
fi
export VISUAL="${EDITOR}"

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

# -- ls --
export LSCOLORS=ExFxGxdxCxDxDxhbadacad
export CLICOLOR=

# -- pager --
export PAGER=less

# -- less --
export LESS="-QR"
export LESSHISTFILE="-"

# -- XDG --
export XDG_CONFIG_HOME=$HOME/config
export XDG_RUNTIME_DIR=/tmp/"$USER"
export XDG_CACHE_HOME=/var/xdg-cache/"$USER"

# -- openssl --
export RANDFILE="${XDG_STATE_HOME:-$HOME/.local/state}"/rnd

# -- query terminal size; useful for serial lines. --
if [ -x /usr/bin/resizewin ]; then
  /usr/bin/resizewin -z
fi

# -- private temp dir --
install -d -o "$USER" -g "$(id -g)" -m 700 /tmp/"$USER"

# -- run zsh if exists --
if [ -x /usr/local/bin/zsh ]; then
  export SHELL=/usr/local/bin/zsh
  case "$-" in
    *i*) exec $SHELL ;;
  esac
fi
