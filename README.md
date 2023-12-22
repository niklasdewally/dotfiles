# Dotfiles

My dotfiles.

## Folders

```
common    -> dotfiles for use on all devices.
mac       -> dotfiles for use on my personal mac.
labs      -> dotfiles for use on st andrews lab machines.
```

## Installation

The contents of each folder are symlinked to `$HOME` using GNU Stow.

**Install dotfiles on Mac:**
```
stow --dir=. --target="$HOME" common mac
```

**Uninstall dotfiles:**
```
stow --dir=. --target="$HOME" -D common mac
```

## Upgrading Nvim

When upgrading `nvim` dotfiles, remember to delete all nvim data directores.
This is especially important for 2023->2024, as I change package managers, and
not doing this will leave all the old package managers stuff behind, which
breaks things.

```sh
rm -r ~/.local/state/nvim
rm -r ~/.local/share/nvim
```
