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
autoload -Uz up-line-or-beginning-search down-line-or-beginning-search compinit colors edit-command-line
compinit
colors

zstyle ':completion:*' list-colors "${(@s.:.)LS_COLORS}"
zstyle ':completion:*' menu select
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
zle -N edit-command-line

bindkey -M vicmd "k" up-line-or-beginning-search
bindkey -M vicmd "j" down-line-or-beginning-search
bindkey -M vicmd "v" edit-command-line

# PROMPT
newline=$'\n'

if [ -n "$SSH_CLIENT" ] || [ -n "$SSH_TTY" ]; then
     SSH_STATUS="%{$bg[yellow]%}%{$fg[black]%} SSH %{$reset_color%}"
fi

function prompt_info() {
     if [ $? != 0 ]; then
          RETURN_CODE=1
     else
          RETURN_CODE=5
     fi

     GIT_INFO_OUTPUT="%{$fg[black]%}"
     command git rev-parse --is-inside-work-tree &>/dev/null && GIT_INFO_OUTPUT="%{$fg[magenta]%}"
     command git diff-index --quiet HEAD -- &>/dev/null; [ $? -eq 1 ] && GIT_INFO_OUTPUT="%{$fg[red]%}"
     echo -ne "\n $(tput setaf 4)$(dirs -c; dirs)\n"
}

function zle-line-init zle-keymap-select {
     VI_NORMAL="%{$bg[green]%}%{$fg[black]%} NORMAL %{$reset_color%}"
     VI_INSERT="%{$bg[blue]%}%{$fg[black]%} INSERT %{$reset_color%}"

     PS1="%{$GIT_INFO_OUTPUT%}>%{$(tput setaf $RETURN_CODE)%}>%{$(tput sgr0)%} "
     RPS1="${${KEYMAP/vicmd/$VI_NORMAL}/(main|viins)/$VI_INSERT}${SSH_STATUS}"

     zle reset-prompt
}

zle -N zle-line-init
zle -N zle-keymap-select

precmd_functions+=(prompt_info)

PROMPT=$PS1
RPROMPT=$RPS1
