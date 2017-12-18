# ENVIRONMENT
export PATH=$HOME/bin:/usr/local/bin:/usr/games:$PATH
export EDITOR=/usr/bin/vim
export BROWSER=/usr/bin/firefox

# HISTORY
export HISTFILE=$HOME/.zsh_history
export HISTSIZE=10000
export SAVEHIST=10000
setopt INC_APPEND_HISTORY
setopt EXTENDED_HISTORY

# ALIASES
alias ls='ls --color=auto'

# BINDINGS
bindkey -v
export KEYTIMEOUT=1
autoload -Uz up-line-or-beginning-search down-line-or-beginning-search compinit colors
compinit
colors
zstyle ':completion:*' list-colors "${(@s.:.)LS_COLORS}"
zstyle ':completion:*' menu select
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey -M vicmd "k" up-line-or-beginning-search
bindkey -M vicmd "j" down-line-or-beginning-search

# PROMPT
newline=$'\n'

function git_info() {
     GIT_INFO_OUTPUT="%{$fg[black]%}"
     command git rev-parse --is-inside-work-tree &>/dev/null && GIT_INFO_OUTPUT="%{$fg[magenta]%}"
     command git diff-index --quiet HEAD -- &>/dev/null; [ $? -eq 1 ] && GIT_INFO_OUTPUT="%{$fg[blue]%}"
     echo -ne "$GIT_INFO_OUTPUT"
}

function zle-line-init zle-keymap-select {
     PS1="$newline %{$fg[blue]%}$(dirs -c; dirs)$newline%{$(git_info)%}>%{$fg[magenta]%}>%{$reset_color%} "

     VI_NORMAL="%{$bg[green]%}%{$fg[black]%} NORMAL %{$reset_color%}"
     VI_INSERT="%{$bg[blue]%}%{$fg[black]%} INSERT %{$reset_color%}"
     RPS1="${${KEYMAP/vicmd/$VI_NORMAL}/(main|viins)/$VI_INSERT}"

     zle reset-prompt
}

zle -N zle-line-init
zle -N zle-keymap-select

PROMPT=$PS1
RPROMPT=$RPS1
