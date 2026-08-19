# .nvimfiles

My neovim config. Lua, [lazy.nvim](https://github.com/folke/lazy.nvim) for
plugins, [Mason](https://github.com/williamboman/mason.nvim) for language
servers, Catppuccin Mocha, `<space>` as leader.

Deployed with [GNU stow](https://www.gnu.org/software/stow/), the same way as
my shell config in
[RogerDewald/.dotfiles](https://github.com/RogerDewald/.dotfiles). This repo
used to live inside that one; it is standalone now, and `.dotfiles` no longer
carries a copy.

---

## Layout

```
nvim/.config/nvim/            <- stow package: becomes ~/.config/nvim/
├── init.lua                  require("daniel")
├── lazy-lock.json            pinned plugin commits
└── lua/daniel/
    ├── init.lua              lazy.nvim bootstrap, autocmds, LSP keymaps
    ├── set.lua               options
    ├── keybinds.lua          non-plugin keymaps
    └── lazy/                 one file per plugin spec
        ├── colors.lua        catppuccin
        ├── lsp.lua           lspconfig + mason + nvim-cmp + LuaSnip
        ├── none-ls.lua       clang-format for C/C++
        ├── python.lua        python-syntax
        ├── snippets.lua      LuaSnip + friendly-snippets
        ├── telescope.lua     telescope
        ├── treesitter.lua    nvim-treesitter
        └── undotree.lua      undotree
```

`lua/daniel/lazy/` is passed to lazy.nvim as `spec = "daniel.lazy"`, so a new
plugin is a new file in that directory — nothing else needs editing.

---

## Dependencies

### Required

| Dependency | Why | Install |
|---|---|---|
| **neovim >= 0.10** | 0.9 is the hard floor (the pinned Telescope 0.1.6 needs it), but current nvim-lspconfig and Mason expect 0.10+, so treat 0.10 as the real minimum | [neovim.io](https://neovim.io) — apt's build is usually too old |
| `git` | lazy.nvim bootstraps itself by cloning, and Telescope's `git_files` needs it | apt |
| `stow` | Symlinks this repo into `~/.config/nvim` | apt |
| **C/C++ compiler** (`build-essential`, `g++`) | nvim-treesitter compiles every parser locally | apt |
| `make` | LuaSnip's `build = "make install_jsregexp"` | apt |
| `unzip`, `curl` | Mason downloads and unpacks servers with them | apt |
| `ripgrep` | Telescope `live_grep` (`<leader>g`) | apt on recent releases, otherwise [BurntSushi/ripgrep](https://github.com/BurntSushi/ripgrep) |
| `npm` / node | Mason installs `pyright` (and other node-based servers) through npm | apt, or [nvm](https://github.com/nvm-sh/nvm) |
| **A Nerd Font** | `vim.g.have_nerd_font = true`, and lspkind draws completion icons — without one they render as boxes | [nerdfonts.com](https://www.nerdfonts.com/font-downloads); I use JetBrainsMono NL |
| A clipboard provider | `<leader>y` / `<leader>Y` write to the `+` register | `xclip` (X11), `wl-clipboard` (Wayland), `win32yank` or `clip.exe` (WSL) |

### Language servers

Mason installs these automatically on first launch — nothing to do by hand:

| Server | Language | Needs on the system |
|---|---|---|
| `lua_ls` | Lua (configured for the neovim runtime: `vim`, `it`, `describe`, `before_each`, `after_each` are known globals) | — |
| `clangd` | C / C++ | — |
| `gopls` | Go | [go](https://go.dev/dl/) |
| `pyright` | Python | node (via `npm`) |

`none-ls` additionally runs **clang-format** on C/C++ (`<leader>fd`). Install it
via `:Mason` or apt's `clang-format`. The style is inline in
`lua/daniel/lazy/none-ls.lua`: LLVM base, indent 4, column limit 160, no
short functions on one line.

### Optional

| Dependency | What it unlocks |
|---|---|
| `tree-sitter` CLI | `auto_install = true` uses it to fetch parsers for filetypes beyond the five in `ensure_installed` |
| `python3` | `<leader>rp` (run this file) |
| `default-jdk` (`javac`, `java`) | `<leader>rj` |
| `http-server` (`npm i -g http-server`) | `<leader>rs` |
| node | `<leader>rn` |
| `tmux` + [.dotfiles](https://github.com/RogerDewald/.dotfiles) | `<C-f>` shells out to `~/.local/bin/scripts/tmux-sessionizer`, which ships in the `bin` package of that repo |

Install the apt-available packages with:

```bash
./dependency_files/ubuntu-dependencies.sh
```

---

## Installation

### 1. Back up any existing config

lazy.nvim will happily start from nothing, but these four directories must be
out of the way first:

```bash
mv ~/.config/nvim{,.bak}; mv ~/.local/share/nvim{,.bak}; mv ~/.local/state/nvim{,.bak}; mv ~/.cache/nvim{,.bak}
```

### 2. Dependencies

```bash
git clone https://github.com/RogerDewald/.nvimfiles.git ~/.nvimfiles
```

```bash
cd ~/.nvimfiles && ./dependency_files/ubuntu-dependencies.sh
```

Then install neovim itself and a Nerd Font (see the table above).

### 3. Stow it

```bash
cd ~/.nvimfiles && stow --target="$HOME" --no-folding nvim
```

That links `~/.config/nvim/init.lua` and friends back to this repo, so editing
the config edits the clone. `--no-folding` links the individual files rather
than symlinking `~/.config/nvim` itself as a directory — without it, anything
neovim writes into `~/.config/nvim` lands inside your git clone.

If stow refuses, something real is still at `~/.config/nvim` — go back to step 1.

### 4. First launch

```bash
nvim
```

lazy.nvim clones itself, installs every plugin at the commits in
`lazy-lock.json`, treesitter compiles its parsers, and Mason installs the four
language servers. Give it a minute. Then check:

| Command | Should show |
|---|---|
| `:Lazy` | All plugins installed, no errors |
| `:Mason` | `lua_ls`, `clangd`, `gopls`, `pyright` installed |
| `:checkhealth` | No missing external dependencies |
| `:TSInstallInfo` | `c`, `lua`, `vim`, `vimdoc`, `query` installed |

---

## Keybinds

Leader is `<space>`.

### Files and search

| Key | Action |
|---|---|
| `<leader>ff` | Telescope find files |
| `<leader>fg` | Telescope git files |
| `<leader>g` | Telescope live grep (needs ripgrep) |
| `<leader>pv` | Netrw file explorer |
| `<leader>u` | Undotree toggle |
| `<C-f>` | tmux-sessionizer in a new tmux window (see `.dotfiles`) |

### Editing

| Key | Mode | Action |
|---|---|---|
| `J` / `K` | visual | Move the selection down / up, reindenting |
| `<leader>p` | visual | Paste over the selection without clobbering the register |
| `<leader>d` | normal, visual | Delete into the black hole register |
| `<leader>y` / `<leader>Y` | normal, visual | Yank to the system clipboard |
| `<leader>s` | normal | Substitute — bare for the whole file, or `5<leader>s` for the next 5 lines |
| `<C-d>` / `<C-u>` | normal | Half-page down / up, keeping the cursor centred |
| `<leader>fd` | normal | Format the buffer (LSP / clang-format) |

### LSP (active once a server attaches)

| Key | Action |
|---|---|
| `gd` | Go to definition |
| `gr` | References |
| `K` | Hover |
| `<leader>vd` | Show the diagnostic under the cursor |
| `<leader>vca` | Code action |
| `<C-h>` (insert) | Signature help |
| `[d` / `]d` | Next / previous diagnostic — note these are swapped relative to the usual vim convention |

### Completion and snippets

| Key | Action |
|---|---|
| `<C-n>` / `<C-p>` | Next / previous completion item (and jump forward/back in a snippet) |
| `<C-Space>` | Confirm the completion (also bound to LuaSnip expand) |
| `<C-q>` | Dismiss the completion menu |
| `<C-E>` | Cycle a snippet choice node |
| `<leader>ncmp` / `<leader>cmp` | Disable / enable completion for this buffer — for prose |

### Terminal and running the current file

| Key | Runs |
|---|---|
| `<leader>t` | A terminal in a horizontal split |
| `<leader>rc` | `g++ % ; ./a.out ; rm a.out` |
| `<leader>rp` | `python3 %` |
| `<leader>rj` | `javac % ; java %:r ; rm %:r.class` |
| `<leader>rn` | `node %` |
| `<leader>rs` | `http-server .` |
| `<Esc><Esc>` | Leave terminal insert mode |

`<C-q>` is unmapped in normal mode on purpose, so it never triggers visual
block mode by accident.

---

## Options worth knowing

From `lua/daniel/set.lua`: relative + absolute line numbers, 4-space expanded
tabs, no wrap, `incsearch` without `hlsearch`, `scrolloff = 8`, always-on sign
column, `updatetime = 50`, and a colour column at 80.

---

## Notes

- **`lazy-lock.json` is tracked, and that is the point.** Every machine gets the
  same plugin commits. Run `:Lazy update` on one machine, commit the changed
  lock file, then pull on the others.
- **The system clipboard is opt-in.** `set.lua` has
  `vim.opt.clipboard:append("")`, which is a no-op — appending an empty value
  leaves `clipboard` unset. So a plain `y` stays in the unnamed register and
  only `<leader>y` / `<leader>Y` reach the system clipboard, which is the
  behaviour I want. If you ever want every yank to go to the clipboard, that
  line is the one to change to `vim.opt.clipboard = "unnamedplus"`.
- **`<C-Space>`, `<C-n>` and `<C-p>` are each bound twice** — once by nvim-cmp
  and once by LuaSnip. cmp wins while its menu is open, LuaSnip handles the rest.
  It works, but that is why a snippet jump sometimes feels like it did the wrong
  thing.
- **First launch is slow.** Treesitter compiling parsers and Mason downloading
  four servers, not a hang.
- **Line endings** are pinned to LF by `.gitattributes`, so a checkout on
  Windows cannot break the shell script in `dependency_files/`.
