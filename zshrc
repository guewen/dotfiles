# Path to your oh-my-zsh configuration.
source ~/.dotfiles/antigen/antigen.zsh

# Bundles from the default repo (robbyrussell's oh-my-zsh).
antigen bundle git
# antigen bundle github
antigen bundle pip
antigen bundle command-not-found
antigen bundle tmuxinator
antigen bundle python
antigen bundle virtualenv
antigen bundle docker
antigen bundle rsync
antigen bundle terraform
antigen bundle emoji

# antigen bundle ssh-agent

# Syntax highlighting bundle.
antigen bundle zsh-users/zsh-syntax-highlighting

antigen bundle zsh-users/zsh-completions src

# Load the theme.
# antigen theme Soliah

# Tell antigen that you're done.
antigen apply

DEFAULT_USER="gbaconnier"

export EDITOR='nvim'

if [[ "$TERM" != "screen-256color" ]] then
    export TERM="xterm-256color"
fi

# custom zsh configs
source ~/.zsh/aliases
source ~/.zsh/config
source ~/.zsh/options
source ~/.zsh/scripts
source ~/.zsh/tmux
source ~/.zsh/bindkey

export PATH=$PATH:$HOME/.rvm/bin:$HOME/bin:/usr/lib/lightdm/lightdm:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games

export PYTHONSTARTUP=~/.pythonrc.py

# load config files for tmuxinator
[[ -s $HOME/.tmuxinator/scripts/tmuxinator ]] && source $HOME/.tmuxinator/scripts/tmuxinator

# use .localrc for settings specific to one system
[[ -f ~/.localrc ]] && . ~/.localrc

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

export PATH="$HOME/.pyenv/bin:$PATH"
eval "$(pyenv init -)"
# eval "$(pyenv virtualenv-init -)"

# antigen adds an alias 'pip=noglop pip', which conflicts with pyenv shims
unalias pip


eval "$(starship init zsh)"
