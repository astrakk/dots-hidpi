# ENVIRONMENT
export PATH=$HOME/bin:/usr/local/bin:/usr/games:$PATH
export EDITOR=/usr/bin/vim
export BROWSER=/usr/bin/firefox

# LOGIN
if [[ "$TTY" == "/dev/tty1" ]]; then
     clear
     startx &>/dev/null
     exit
fi

# INSTALL PATH
export ZSH=~/.oh-my-zsh

# THEME
ZSH_THEME="less-refined"

# PLUGINS
plugins=(git)

source $ZSH/oh-my-zsh.sh

# ALIASES
alias ls='ls --color=auto'

# FLUFF
neofetch
