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
zmodload zsh/complist
compinit
colors

zstyle ':completion:*' list-colors "${(@s.:.)LS_COLORS}"
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
zstyle ':completion:*' menu select
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
zle -N edit-command-line

bindkey "\e[3~" delete-char
bindkey -M vicmd "\e[3~" delete-char
bindkey -M vicmd "k" up-line-or-beginning-search
bindkey -M vicmd "j" down-line-or-beginning-search
bindkey -M vicmd "V" edit-command-line
bindkey -M menuselect '^[[Z' reverse-menu-complete

# PROMPT

function info_os() {
     if [ -f /etc/os-release ]; then
          # freedesktop.org and systemd
          . /etc/os-release
          OS=$NAME
          VER=$VERSION_ID
     elif type lsb_release >/dev/null 2>&1; then
          # linuxbase.org
          OS=$(lsb_release -si)
          VER=$(lsb_release -sr)
     elif [ -f /etc/lsb-release ]; then
          # For some versions of Debian/Ubuntu without lsb_release command
          . /etc/lsb-release
          OS=$DISTRIB_ID
          VER=$DISTRIB_RELEASE
     elif [ -f /etc/debian_version ]; then
          # Older Debian/Ubuntu/etc.
          OS=Debian
          VER=$(cat /etc/debian_version)
     elif [ -f /etc/SuSe-release ]; then
          # Older SuSE/etc.
          ...
     elif [ -f /etc/redhat-release ]; then
          # Older Red Hat, CentOS, etc.
          ...
     else
          # Fall back to uname, e.g. "Linux <version>", also works for BSD, etc.
          OS=$(uname -s)
          VER=$(uname -r)
     fi

     echo -ne "$OS $VER"
}

function info_kernel() {
     echo -ne "$(uname -r)"
}

function info_uptime() {
     UPTIME_RAW=${"$(cat /proc/uptime)"/.*}
     UPTIME_DAYS="$((UPTIME_RAW / 60 / 60 / 24))d "
     UPTIME_HOURS="$((UPTIME_RAW / 60 / 60 % 24))h "
     UPTIME_MINS="$((UPTIME_RAW / 60 % 60))m "
     UPTIME_SECS="$((UPTIME_RAW % 60))s"
     
     if [ $UPTIME_DAYS = "0d " ]; then
          unset UPTIME_DAYS
     else
          UPTIME_SECS="0s"
     fi

     if [ $UPTIME_HOURS = "0h " ]; then
          unset UPTIME_HOURS
     fi

     if [ $UPTIME_MINS = "0m " ]; then
          unset UPTIME_MINS
     fi

     if [ $UPTIME_SECS = "0s" ]; then
          unset UPTIME_SECS
     fi

     echo -ne "$UPTIME_DAYS$UPTIME_HOURS$UPTIME_MINS$UPTIME_SECS"
}

function get_info() {
     INFO_OS=$(info_os)
     INFO_KERNEL=$(info_kernel)
     INFO_UPTIME=$(info_uptime)

     echo -ne "$(tput setaf 4)OS$(tput sgr0) $(tput setaf 5)$INFO_OS$(tput sgr0)\n"
     echo -ne "$(tput setaf 4)KN$(tput sgr0) $(tput setaf 5)$INFO_KERNEL$(tput sgr0)\n"
     echo -ne "$(tput setaf 4)UT$(tput sgr0) $(tput setaf 5)$INFO_UPTIME$(tput sgr0)\n"
}

function precmd() {
     echo -ne "\n$(tput setaf 8)$(whoami) $(tput setaf 4)$(dirs -c; dirs)\n"
}

function colour_git() {
     echo -ne "$(tput setaf 8)"
     if git rev-parse --is-inside-work-tree &>/dev/null; then
         if git diff-index --quiet HEAD -- &>/dev/null; then
              echo -ne "$(tput setaf 5)"
         else
              echo -ne "$(tput setaf 1)"
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

get_info
set_prompt
set_rprompt
