#!/usr/bin/env bash
# Install the apt packages this neovim config expects, on Debian/Ubuntu/WSL.
#
#   ./dependency_files/ubuntu-dependencies.sh
#
# Neovim itself is deliberately NOT installed here: the version in apt is
# usually too old for this config. See the README.

set -euo pipefail

packages=(
    # Build toolchain — treesitter compiles its parsers, LuaSnip builds
    # jsregexp, and Mason builds some of its servers.
    build-essential
    g++
    make
    unzip
    curl
    git

    # Telescope live_grep
    ripgrep

    # Mason installs the node-based language servers with these
    npm

    # Language runtimes the <leader>r* run-this-file bindings shell out to
    python3
    python3-pip
    default-jdk

    # System clipboard, for <leader>y / <leader>Y ("+ register).
    # On Wayland swap this for wl-clipboard; under WSL neither is needed if
    # win32yank is on PATH.
    xclip
)

SUDO=""
if [[ $EUID -ne 0 ]]; then
    SUDO="sudo"
fi

$SUDO apt-get update
# One call, not one per package: apt resolves the set together, and a single
# missing name no longer silently skips everything after it.
$SUDO apt-get install -y "${packages[@]}"

echo
echo "Done. Still to do by hand:"
echo "  - neovim >= 0.10   https://neovim.io  (apt's build is usually too old)"
echo "  - a Nerd Font      https://www.nerdfonts.com  (JetBrainsMono NL)"
echo "  - stow             to symlink this repo into ~/.config/nvim"
echo "  - optional: go (gopls), nvm/node, tree-sitter CLI for auto_install"
