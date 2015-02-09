#
# csh/tcsh initialization


# -- interactive shell --
if ($?prompt) then
  # -- prompt --
  if ( $?tcsh ) then
    set prompt = "[%n@%m:%~]%# "
  else
    set prompt = "[$USER@`hostname -s`]% "
  endif
  
  
  # -- shell vars --
  set filec
  set history = 100
  # set savehist = 100
  set histdup = erase
  set ignoreeof
  set mail = (/var/mail/$USER)
  
  if ( $?tcsh ) then
    set autolist = ambiguous
    set matchbeep = never
    set visiblebell
    set nobeep
  endif
  
  
  # -- key bindings --
  if ( $?tcsh ) then
    bindkey "^W" backward-delete-word
    
    # bindkey -k up history-search-backward   # instead of history-up
    # bindkey -k down history-search-forward
    
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
      bindkey "$key_ppage" undefined-key
    endif
    unset key_ppage
    
    set key_npage="`echotc -s kN`"            # Page Down Key
    if ( "$key_npage" != "" ) then
      bindkey "$key_npage" undefined-key
    endif
    unset key_npage
  endif
  
  
  # -- aliases --
  alias la  ls -A
  alias lf  ls -F
  alias ll  ls -l
  alias cp  cp -i
  alias mv  mv -i
  
  
  # -- completions --
  if ( $?tcsh ) then
    complete cd         p/1/d/          # Directories only
    complete chdir      p/1/d/
    complete pushd      p/1/d/
    complete popd       p/1/d/
    
    complete set        'c/*=/f/' 'p/1/s/=' 'n/=/f/'
    complete unset      'n/*/s/'
    complete setenv     'p/1/e/' 'c/*:/f/'
    complete unsetenv   'n/*/e/'
  endif
endif
