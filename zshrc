# Path to your oh-my-zsh configuration.
source ~/.dotfiles/antigen/antigen.zsh

# Load the oh-my-zsh's library.
antigen use oh-my-zsh

# Bundles from the default repo (robbyrussell's oh-my-zsh).
antigen bundle git
antigen bundle github
antigen bundle heroku
antigen bundle pip
antigen bundle command-not-found
antigen bundle tmuxinator
antigen bundle python
antigen bundle vagrant
antigen bundle docker

# Syntax highlighting bundle.
antigen bundle zsh-users/zsh-syntax-highlighting

# Load the theme.
antigen theme Soliah

# Tell antigen that you're done.
antigen apply

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
# plugins=(git github python vagrant rvm tmuxinator)

# custom zsh configs
source ~/.zsh/aliases
source ~/.zsh/config
source ~/.zsh/options
source ~/.zsh/scripts
source ~/.zsh/tmux
source ~/.zsh/bindkey
source ~/.zsh/virtualenvwrapper


# Customize to your needs...
export PATH=$PATH:$HOME/.rvm/bin:$HOME/bin:/usr/lib/lightdm/lightdm:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:$HOME/.local/bin

export PYTHONSTARTUP=~/.pythonrc.py

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

# load config files for tmuxinator
[[ -s $HOME/.tmuxinator/scripts/tmuxinator ]] && source $HOME/.tmuxinator/scripts/tmuxinator

# load ssh agent
[[ -s $HOME/.sshagent ]] && source $HOME/.sshagent

# use .localrc for settings specific to one system
[[ -f ~/.localrc ]] && . ~/.localrc
