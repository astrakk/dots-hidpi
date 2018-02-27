# ENVIRONMENT
export PATH=$HOME/bin:/usr/local/bin:/usr/games:$PATH
export EDITOR=/usr/bin/vim
export BROWSER=/usr/bin/firefox
export TERMINAL=$HOME/bin/st
fpath=( "$HOME/.zsh/functions/Completion/Unix" "${fpath[@]}" )
source $HOME/.zsh_colours

# THEME
source $HOME/.config/tty_colours/config

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
zmodload zsh/complist
compinit
colors

zstyle ':completion:*' list-colors "${(@s.:.)LS_COLORS}"
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
zstyle ':completion:*' menu select
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
zle -N edit-command-line

bindkey "^[[P" delete-char 
bindkey -M vicmd "^[[P" delete-char
bindkey "^?" backward-delete-char 
bindkey -M vicmd "^?" backward-char
bindkey -M vicmd "k" up-line-or-beginning-search
bindkey -M vicmd "j" down-line-or-beginning-search
bindkey -M vicmd "V" edit-command-line
bindkey -M menuselect "^[[Z" reverse-menu-complete
bindkey -M menuselect "\e" send-break

# PROMPT
function precmd() {
     echo -ne "\n$(tput setaf 8)$(whoami) $(tput setaf 4)$(dirs -c; dirs)\n"
}

function colour_git() {
     echo -ne "$(tput setaf 8)"

     if $(git rev-parse --is-inside-work-tree >/dev/null 2>&1); then
          if [[ -n $(git status --porcelain --ignore-submodules) ]]; then
               echo -ne "$(tput setaf 1)"
          else
               echo -ne "$(tput setaf 5)"
          fi
     fi
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
     COLOUR_ERR=$(colour_err)
     COLOUR_VI=$(colour_vi)
     COLOUR_GIT=$(colour_git)
     COLOUR_NORMAL=$(tput sgr0)

     # Set up the left prompt
     PROMPT="%{$COLOUR_GIT%}>%{$COLOUR_VI%}>%{$COLOUR_ERR%}>%{$COLOUR_NORMAL%} "
}

function set_rprompt() {
     # Store required colours
     COLOUR_SSH=$(colour_ssh)
     COLOUR_NORMAL=$(tput sgr0)

     # Enable the right prompt if connection is via SSH
     if [ -n "$SSH_CLIENT" ] || [ -n "$SSH_TTY" ]; then
          RPROMPT="%{$COLOUR_SSH%}%m%{$COLOUR_NORMAL%}"
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

function zle-line-finish {
     # Blank the right prompt to remove SSH info
     RPROMPT=""

     # Reset the prompt
     zle reset-prompt
}

zle -N zle-line-finish

astfetch
set_prompt
set_rprompt
