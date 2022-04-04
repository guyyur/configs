
# .cshrc - csh resource script, read at beginning of execution by each shell
#
# see also csh(1), environ(7).


# -- interactive shell --
if ($?prompt) then
  # -- prompt --
  if ( $?tcsh ) then
    set prompt = "[%m:%~]%# "
  else
    set prompt = "[`hostname -s`]# "
  endif
  
  
  # -- shell vars --
  set filec
  set history = 500
  # set savehist = (500 merge)
  set histdup = erase
  set ignoreeof
  set mail = (/var/mail/root)
  
  if ( $?tcsh ) then
    set autolist = ambiguous
    set matchbeep = never
    set visiblebell
    set nobeep
  endif
  
  
  # -- key bindings --
  if ( $?tcsh ) then
    bindkey "^W" backward-delete-word
    
    set key_ic="`echotc -s kI`"               # Insert Key
    if ( "$key_ic" != "" ) then
      bindkey "$key_ic" overwrite-mode
    endif
    unset key_ic
    
    set key_dc="`echotc -s kD`"               # Delete Key
    if ( "$key_dc" != "" ) then
      bindkey "$key_dc" delete-char
    endif
    unset key_dc
    
    set key_ppage="`echotc -s kP`"            # Page Up Key
    if ( "$key_ppage" != "" ) then
      bindkey "$key_ppage" history-search-backward
    endif
    unset key_ppage
    
    set key_npage="`echotc -s kN`"            # Page Down Key
    if ( "$key_npage" != "" ) then
      bindkey "$key_npage" history-search-forward
    endif
    unset key_npage
  endif
  
  
  # -- aliases --
  alias la  ls -A
  alias lf  ls -F
  alias ll  ls -l
  alias cp  cp -i
  alias mv  mv -i
  alias grep  grep --color=auto
  alias whereis  whereis -x
  
  
  # -- completions --
  if ( $?tcsh ) then
    complete cd             p/1/d/          # Directories only
    complete chdir          p/1/d/
    complete pushd          p/1/d/
    complete popd           p/1/d/
    
    complete set            'c/*=/f/' 'p/1/s/=' 'n/=/f/'
    complete unset          'n/*/s/'
    complete setenv         'p/1/e/' 'c/*:/f/'
    complete unsetenv       'n/*/e/'
    
    complete pkg            'p/1/`pkg -l`/' 'n/info/`pkg query "%n-%v"`/' 'N/info/`pkg query "%n-%v"`/' 'n/delete/`pkg query "%n-%v"`/'
  endif
endif
