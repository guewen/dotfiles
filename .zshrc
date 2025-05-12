if [[ -e /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh ]]; then
  source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
fi

# The following lines were added by compinstall
zstyle :compinstall filename '/home/guewenb/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

if [[ -e ~/.localrc ]]; then
  source ~/.localrc
fi

# custom zsh configs
source ~/.zsh/aliases
source ~/.zsh/config
source ~/.zsh/options
source ~/.zsh/scripts
source ~/.zsh/bindkey
source ~/.zsh/theming

# https://fwuensche.medium.com/how-to-manage-your-dotfiles-with-git-f7aeed8adf8b
alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'

eval "$(starship init zsh)"
