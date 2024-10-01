
# -- terminfo --
export TERMINFO=/usr/share/terminfo-lite-unmodified

# -- editors --
export EDITOR=nano
export VISUAL="${EDITOR}"

# -- pager --
export PAGER=less

# -- less --
export LESS="-QR"
export LESSHISTFILE="-"

# -- systemd --
export SYSTEMD_LESS="QRSMK"

# -- XDG --
export XDG_CONFIG_HOME=$HOME/config
export XDG_CACHE_HOME=/var/xdg-cache/"$USER"

# -- openssl --
export RANDFILE="${XDG_STATE_HOME:-$HOME/.local/state}"/rnd

# -- private temp dir --
install -d -o "$USER" -g "$(id -g)" -m 700 /tmp/"$USER"
