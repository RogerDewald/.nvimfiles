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
- stow

## Dependencies from other sites
- go from https://go.dev/dl/
- ripgrep from https://github.com/BurntSushi/ripgrep
- neovim from https://neovim.io
- nvm from https://github.com/nvm-sh/nvm

## Usage
```bash
git clone https://github.com/RogerDewald/LazyNeovimConfig.git ~/.config/nvim
```

```bash
cd .nvimfiles/
stow nvim
```
