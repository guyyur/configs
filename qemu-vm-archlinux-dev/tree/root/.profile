
# -- editors --
export EDITOR=nano
export VISUAL="${EDITOR}"

# -- pager --
export PAGER=less

# -- less --
export LESS="-QR"
export LESSHISTFILE="-"

# -- grep --
export GREP_COLORS=ne

# -- systemd --
export SYSTEMD_LESS="QRSMK"

# -- XDG --
export XDG_CONFIG_HOME=$HOME/config
export XDG_CACHE_HOME=/var/cache/xdg/"$USER"
export XDG_STATE_HOME=/var/lib/xdg/"$USER"

# -- openssl --
export RANDFILE="${XDG_STATE_HOME:-$HOME/.local/state}"/rnd

# -- private temp dir --
install -d -o "$USER" -g "$(id -g)" -m 700 /tmp/"$USER"
