# Dotfiles

My dotfiles.

## Folders

```
common    -> dotfiles for use on all devices.
device-xxx ->§
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

# Device specific bash config
.bashrc.local and .bash_profile.local can be used to add extra bash settings on a per device basis.

# Loading order of bash initialisation files

The main advantage of using profile over bashrc is that it is read by the GUI session too.
Put environment variables, etc here.

Login shells:

1. .bash_profile
2. .profile
3. .profile.local (if exists)
4. .bashrc
5. files in .bashrc.d
6. .bashrc.local (if exists)


Interactive shells:

1. .bashrc
2. files in .bashrc.d
3. .bashrc.local (if exists)
