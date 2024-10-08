
# -- parameters --
HISTSIZE=500
PS1='[%m:%~]%# '
WORDCHARS='*?_-.[]~=&;!#$%^(){}<>'

# -- options --
setopt AUTO_LIST
unsetopt AUTOREMOVESLASH
unsetopt BEEP
unsetopt HIST_BEEP
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_REDUCE_BLANKS
unsetopt HUP
setopt IGNORE_EOF
unsetopt LIST_BEEP

# -- keys --
[[ -z "${terminfo[khome]}" ]] || bindkey "${terminfo[khome]}" beginning-of-line
[[ -z "${terminfo[kend]}" ]] || bindkey "${terminfo[kend]}" end-of-line
[[ -z "${terminfo[kich1]}" ]] || bindkey "${terminfo[kich1]}" overwrite-mode
[[ -z "${terminfo[kdch1]}" ]] || bindkey "${terminfo[kdch1]}" delete-char
[[ -z "${terminfo[kcuu1]}" ]] || bindkey "${terminfo[kcuu1]}" up-line-or-history
[[ -z "${terminfo[kcud1]}" ]] || bindkey "${terminfo[kcud1]}" down-line-or-history
[[ -z "${terminfo[kcub1]}" ]] || bindkey "${terminfo[kcub1]}" backward-char
[[ -z "${terminfo[kcuf1]}" ]] || bindkey "${terminfo[kcuf1]}" forward-char
[[ -z "${terminfo[kpp]}" ]] || bindkey "${terminfo[kpp]}" history-beginning-search-backward
[[ -z "${terminfo[knp]}" ]] || bindkey "${terminfo[knp]}" history-beginning-search-forward

if [[ -n "${terminfo[smkx]}" ]]; then
  function zle-line-init ()
  {
      echoti smkx
  }
  zle -N zle-line-init
fi

if [[ -n "${terminfo[rmkx]}" ]]; then
  function zle-line-finish ()
  {
      echoti rmkx
  }
  zle -N zle-line-finish
fi

# -- builtins --
disable kill
disable history
disable where
disable which

# -- aliases --
alias la='ls -A'
alias lf='ls -F'
alias ll='ls -l'
alias cp='cp -i'
alias mv='mv -i'
alias grep='grep --color=auto'

# -- completions --
autoload -Uz compinit
compinit -d $XDG_CACHE_HOME/zcompdump
compdef -d diff
compdef -d mount
compdef -d objdump
