# ENVIRONMENT
export PATH=$HOME/bin:/usr/local/bin:/usr/games:$PATH
export EDITOR=/usr/bin/vim
export BROWSER=/usr/bin/firefox

# INSTALL PATH
export ZSH=~/.oh-my-zsh

# THEME
if [[ $TERM = "xterm-termite" ]]; then
     export TERM=xterm-256color
fi

ZSH_THEME="less-refined"

# PLUGINS
plugins=(git)

source $ZSH/oh-my-zsh.sh

# ALIASES
alias ls='ls --color=auto'

# FLUFF
neofetch
