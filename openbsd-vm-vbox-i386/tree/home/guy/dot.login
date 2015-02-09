#
# csh/tcsh login file


# -- BLOCKSIZE env var --
setenv BLOCKSIZE    1k


# -- locale --


# -- EDITOR, VISUAL env vars --
if ( -x /usr/local/bin/nano ) then
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
