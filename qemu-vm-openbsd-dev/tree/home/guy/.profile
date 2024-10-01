# .profile - Bourne Shell startup script for login shells

# -- set ENV to a file invoked each time sh is started interactively --
export ENV=$HOME/.shrc

# -- path --
export PATH=/sbin:/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/usr/games:/usr/X11R6/bin:$HOME/bin

# -- editors --
if [ -x /usr/local/bin/nano ]; then
  export EDITOR=nano
else
  export EDITOR=vi
fi
export VISUAL="${EDITOR}"

# -- locale --

# -- block size --
export BLOCKSIZE=1k

# -- pager --
export PAGER=less

# -- less --
export LESS="-QR"
export LESSHISTFILE="-"

# -- XDG --
export XDG_CONFIG_HOME=$HOME/config
export XDG_RUNTIME_DIR=/tmp/"$USER"
export XDG_CACHE_HOME=/var/xdg-cache/"$USER"

# -- libressl --
export RANDFILE="${XDG_STATE_HOME:-$HOME/.local/state}"/rnd

# -- private temp dir --
install -d -o "$USER" -g "$(id -g)" -m 700 /tmp/"$USER"

# -- run zsh if exists --
if [ -x /usr/local/bin/zsh ]; then
  export SHELL=/usr/local/bin/zsh
  case "$-" in
    *i*) exec $SHELL ;;
  esac
fi
