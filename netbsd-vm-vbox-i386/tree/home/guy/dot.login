#
# This is the default .login file.
# Users are expected to edit it to meet their own needs.
#
# The commands in this file are executed when a csh user first
# logs in.  This file is processed after .cshrc.
#
# See csh(1) for details.
#


# -- BLOCKSIZE env var --
setenv BLOCKSIZE    1k


# -- locale --
setenv MM_CHARSET   UTF-8
setenv LANG         en_US.UTF-8
setenv LC_COLLATE   en_US.UTF-8
setenv LC_CTYPE     en_US.UTF-8
setenv LC_MESSAGES  en_US.UTF-8
setenv LC_MONETARY  he_IL.UTF-8
setenv LC_NUMERIC   en_US.UTF-8
setenv LC_TIME      en_GB.UTF-8


# -- EDITOR, VISUAL env vars --
if ( -x /usr/pkg/bin/nano ) then
  setenv EDITOR       nano
else
  setenv EDITOR       vi
endif
setenv VISUAL       "${EDITOR}"


# -- PAGER env var --
setenv PAGER        less


# -- less env vars --
setenv LESS "-QR"
setenv LESSHISTFILE "-"


# -- set ENV to a file invoked each time sh is started --
setenv ENV  $HOME/.shrc


# -- set XDG env vars --
setenv XDG_CONFIG_HOME $HOME/config
setenv XDG_CACHE_HOME  /var/xdg-cache/"$USER"
