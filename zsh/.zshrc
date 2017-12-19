# ENVIRONMENT
export PATH=$HOME/bin:/usr/local/bin:/usr/games:$PATH
export EDITOR=/usr/bin/vim
export BROWSER=/usr/bin/firefox
source $HOME/.zsh_colours

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

function precmd() {
     echo -ne "\n  $(tput setaf 4)$(dirs -c; dirs)\n"
}

function colour_git() {
     echo -ne "$(tput setaf 8)"
     command git rev-parse --is-inside-work-tree &>/dev/null && echo -ne "$(tput setaf 5)"
     command git diff-index --quiet HEAD -- &>/dev/null; [ $? -eq 1 ] && echo -ne "$(tput setaf 1)"
}

function colour_vi() {
     case ${KEYMAP} in
          vicmd)
               echo -ne $(tput setaf 2)
               ;;
          *)
               echo -ne $(tput setaf 4)
               ;;
     esac
}

function colour_err() {
     if [ $? != 0 ]; then
          echo -ne "$(tput setaf 1)"
     else
          echo -ne "$(tput setaf 5)"
     fi
}

function colour_ssh() {
     echo -ne "$(tput setaf 8)"
}

function set_prompt() {
     # Store required colours
     COLOUR_NORMAL=$(tput sgr0)
     COLOUR_ERR=$(colour_err)
     COLOUR_VI=$(colour_vi)
     COLOUR_GIT=$(colour_git)

     # Set up the left prompt
     PROMPT="%{$COLOUR_GIT%}>%{$COLOUR_VI%}>%{$COLOUR_ERR%}>%{$COLOUR_NORMAL%} "
}

function set_rprompt() {
     # Store required colours
     COLOUR_SSH=$(colour_ssh)

     # Enable the right prompt if connection is via SSH
     if [ -n "$SSH_CLIENT" ] || [ -n "$SSH_TTY" ]; then
          RPROMPT="%{$COLOUR_SSH%}%n@%m%{$COLOUR_NORMAL%}"
     fi
}

function zle-line-init zle-keymap-select {
     # Set the left and right prompts
     set_prompt
     set_rprompt

     # Reset the prompt
     zle reset-prompt
}

zle -N zle-line-init
zle -N zle-keymap-select

set_prompt
set_rprompt
