# My personal minimal vim setup

A small, old-school Vim setup for Rust, JavaScript, HTML, and CSS development.

This setup intentionally avoids Neovim, file-tree plugins, themes, statusline plugins, fuzzy finders, and other heavy tooling. It uses native Vim features where possible and adds only one major plugin: `coc.nvim` for LSP autocomplete, diagnostics, code actions, and auto-import support.

## Goals

- Use **real Vim**, not Neovim
- Keep configuration minimal
- Use native **Netrw** as the file manager
- Support:
  - Rust autocomplete and auto-imports
  - JavaScript autocomplete and auto-imports
  - HTML/CSS autocomplete
  - Diagnostics
  - Go to definition
  - Code actions
  - Formatting
- Keep swap/undo/backup files out of project directories
- Work well in default macOS Terminal

---

## Requirements

Recommended:

- Vim 9+
- Node.js 20+
- Git
- Rust toolchain for Rust development

Check versions:

```bash
vim --version | head -1
node -v
```

Install Rust source support:

```bash
rustup component add rust-src
```

---

## Install vim-plug

```bash
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
```

---

## Create Vim temp directories

```bash
mkdir -p ~/.vim/swap ~/.vim/undo ~/.vim/backup
chmod 700 ~/.vim ~/.vim/swap ~/.vim/undo ~/.vim/backup
```

---

## Install plugins

Open Vim:

```bash
vim
```

Run:

```vim
:PlugInstall
```

Restart Vim.

If Coc extensions do not install automatically, run:

```vim
:CocInstall coc-rust-analyzer coc-tsserver coc-html coc-css coc-json
```

---

## Rust setup

Open a real Cargo project:

```bash
cargo new vim_test
cd vim_test
vim src/main.rs
```

Inside Vim:

```vim
:CocInfo
```

If Rust analyzer is missing, run:

```vim
:CocCommand rust-analyzer.install
```

---

## JavaScript setup

Use a real project directory:

```bash
mkdir js-test
cd js-test
npm init -y
vim index.js
```

Optional `jsconfig.json`:

```json
{
  "compilerOptions": {
    "checkJs": true,
    "module": "commonjs",
    "target": "es2022"
  },
  "exclude": ["node_modules"]
}
```

---

## Keybindings

### Coc / LSP

| Key | Action |
|---|---|
| `gd` | Go to definition |
| `gy` | Go to type definition |
| `gi` | Go to implementation |
| `gr` | Show references |
| `K` | Show hover documentation |
| `[g` | Previous diagnostic |
| `]g` | Next diagnostic |
| `\rn` | Rename symbol |
| `\ca` | Code action |
| `\qf` | Quick fix |
| `:Format` | Format file |
| `:OR` | Organize imports |
| `Ctrl-o` | Jump back |
| `Ctrl-i` | Jump forward |
| `\o` | Jump back |
| `\i` | Jump forward |

### Autocomplete

| Key | Action |
|---|---|
| `Tab` | Next completion item |
| `Shift+Tab` | Previous completion item |
| `Enter` | Confirm completion |
| `Ctrl+@` | Trigger completion manually |

### Netrw

| Key / Command | Action |
|---|---|
| `:Explore` / `:Ex` | Open file explorer |
| `:Lexplore` | Toggle left file explorer |
| `\e` | Toggle left Netrw explorer |
| `\E` | Open Netrw explorer |
| `Enter` | Open file / enter directory |
| `-` | Go up one directory |
| `u` | Go back |
| `U` | Go forward |
| `gh` | Show/hide hidden files |
| `%` | Create new file |
| `d` | Create new directory |
| `R` | Rename file/directory |
| `D` | Delete file/directory |
| `v` | Open in vertical split |
| `o` | Open in horizontal split |
| `t` | Open in new tab |
| `i` | Cycle listing style |
| `s` | Change sort mode |
| `r` | Reverse sort order |

### Tabs

| Key | Action |
|---|---|
| `Tab` | Next tab |
| `Shift+Tab` | Previous tab |
| `\t` | New tab with Netrw |
| `\q` | Close current tab |

### Buffers

| Key | Action |
|---|---|
| `\bn` | Next buffer |
| `\bp` | Previous buffer |
| `\bd` | Delete current buffer |
| `\bl` | List buffers |

---

## Daily workflow

Open a project:

```bash
cd my-project
vim .
```

Open files with Netrw:

```text
Enter   open file
v       open in vertical split
t       open in new tab
```

Use LSP:

```text
gd       go to definition
Ctrl-o   jump back
K        show docs
\ca      code action / auto-import
\qf      quick fix
:OR      organize imports
:Format  format file
```

Use buffers after files are open:

```text
\bl      list buffers
\bn      next buffer
\bp      previous buffer
\bd      close buffer
```

---

## Swap file behavior

This config keeps swap files in:

```bash
~/.vim/swap
```

not inside your project directories.

If Vim shows:

```text
E303: Unable to open swap file
```

create/fix the directories:

```bash
mkdir -p ~/.vim/swap ~/.vim/undo ~/.vim/backup
chmod 700 ~/.vim ~/.vim/swap ~/.vim/undo ~/.vim/backup
```

To edit `.vimrc` temporarily without swap:

```bash
vim -n ~/.vimrc
```

Use `-n` only for fixing config, not as normal daily usage.

---

## Cleaning old project swap files

Check:

```bash
find . -type f -name ".*.sw?" -print
```

Delete, only if no Vim session is currently using them:

```bash
find . -type f \( -name ".*.swp" -o -name ".*.swo" -o -name ".*.swn" \) -delete
```

---

## Philosophy

This setup is intentionally boring.

- Netrw opens files.
- Buffers hold working files.
- Splits organize the screen.
- Tabs separate workspaces.
- Coc gives modern language-server features.
- Everything else stays close to native Vim.

No fake IDE. No VS Code cosplay. Just Vim, language servers, and a basement.
