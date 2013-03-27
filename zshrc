# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# custom zsh configs
source ~/.zsh/aliases
source ~/.zsh/config
source ~/.zsh/options
source ~/.zsh/scripts
source ~/.zsh/tmux
source ~/.zsh/bindkey
source ~/.zsh/virtualenvwrapper

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
#ZSH_THEME="robbyrussell"
ZSH_THEME="Soliah"
#ZSH_THEME="agnoster-gb"
# agnoster theme hides user when logged myself
DEFAULT_USER="gbaconnier"

export EDITOR='vim'

if [[ "$TERM" != "screen-256color" ]] then
    export TERM="xterm-256color"
fi

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
# COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git python rake extract bundler vagrant rvm)

source $ZSH/oh-my-zsh.sh

# Customize to your needs...
export PATH=$HOME/bin:/usr/lib/lightdm/lightdm:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:$HOME/.rvm/bin

export PYTHONSTARTUP=~/.pythonrc.py

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

# load config files for tmuxinator
[[ -s $HOME/.tmuxinator/scripts/tmuxinator ]] && source $HOME/.tmuxinator/scripts/tmuxinator

# load ssh agent
[[ -s $HOME/.sshagent ]] && source $HOME/.sshagent

# use .localrc for settings specific to one system
[[ -f ~/.localrc ]] && . ~/.localrc
