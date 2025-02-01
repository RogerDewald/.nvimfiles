# My dotfiles

Only for my NeoVim config, and maybe tmux

## Cleaning up cache
if you already have an nvim config, you can wipe it with these commands: 
```bash
mv ~/.config/nvim{,.bak}
mv ~/.local/share/nvim{,.bak}
mv ~/.local/state/nvim{,.bak}
mv ~/.cache/nvim{,.bak}
```
## Dependencies from APT repo

- curl
- g++
- git
- unzip
- npm

# Dependencies from other sites
install go from https://go.dev/dl/

install ripgrep from https://github.com/BurntSushi/ripgrep

install neovim from https://neovim.io

install nvm from https://github.com/nvm-sh/nvm

nvm install 18

nvm use v18

git clone https://github.com/RogerDewald/LazyNeovimConfig.git ~/.config/nvim
