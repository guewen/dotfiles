# Restore

```bash
alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
git clone --bare git@github.com:guewen/dotfiles.git $HOME/.dotfiles -b <branch>
dotfiles config --local status.showUntrackedFiles no

# For all "deleted" files
dotfiles reset -- <file>
dotfiles restore -- <file>
```

See https://harfangk.github.io/2016/09/18/manage-dotfiles-with-a-git-bare-repository.html


Packages to install (at least)

```
starship
ripgrep
keychain
neovim
tmux
piow
zsh-autosuggestions
gnome-power-manager
blueberry
awww
z
https://github.com/tmux-plugins/tpm
```
