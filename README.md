# Dotfiles

My dotfiles.


## Folders

The contents of each folder are symlinked to `$HOME`.

```
common    -> dotfiles for use on all devices.
mac       -> dotfiles for use on my personal mac.
labs      -> dotfiles for use on st andrews lab machines.
```

## Installation


**Install dotfiles on Mac:**
```
stow --dir=. --target="$HOME" common mac
```

**Uninstall dotfiles:**
```
stow --dir=. --target="$HOME" -D common mac
```

