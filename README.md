# Restore

```bash
alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
git clone --bare git@github.com:guewen/dotfiles.git $HOME/.dotfiles -b <branch>
dotfiles config --local status.showUntrackedFiles no

# For all "deleted" files
dotfiles reset ...
dotfiles restore ...
```

See https://harfangk.github.io/2016/09/18/manage-dotfiles-with-a-git-bare-repository.html
