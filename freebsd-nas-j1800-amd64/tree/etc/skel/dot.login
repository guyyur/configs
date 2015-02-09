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


# -- set ENV to a file invoked each time sh is started interactively. --
setenv ENV  $HOME/.shrc
