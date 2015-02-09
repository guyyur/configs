#
# .login - csh login script, read by login shell, after `.cshrc' at login.
#
# see also csh(1), environ(7).


# -- path --
setenv PATH  /sbin:/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:$HOME/bin


# -- locale --
setenv MM_CHARSET   UTF-8
setenv LANG         en_US.UTF-8
setenv LC_COLLATE   en_US.UTF-8
setenv LC_CTYPE     en_US.UTF-8
setenv LC_MESSAGES  en_US.UTF-8
setenv LC_MONETARY  he_IL.UTF-8
setenv LC_NUMERIC   en_US.UTF-8
setenv LC_TIME      en_GB.UTF-8


# -- block size --
setenv BLOCKSIZE  K


# -- ncurses --
setenv NCURSES_NO_UTF8_ACS 1


# -- EDITOR, VISUAL env vars --
if ( -x /usr/local/bin/nano ) then
  setenv EDITOR       nano
else
  setenv EDITOR       ee
endif
setenv VISUAL       "${EDITOR}"


# -- ls env vars --
setenv LSCOLORS     ExFxGxdxCxDxDxhbadacad
setenv CLICOLOR


# -- PAGER env var --
setenv PAGER        less


# -- less env vars --
setenv LESS "-QR"
setenv LESSHISTFILE "-"


# -- set ENV to a file invoked each time sh is started interactively. --
setenv ENV  $HOME/.shrc


# -- set XDG env vars --
setenv XDG_CONFIG_HOME $HOME/config
setenv XDG_CACHE_HOME  /var/xdg-cache/"$USER"
