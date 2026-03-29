# dotfiles

My personal dotfiles configuration.

<!-- vim: cc=80 tw=80
-->

### Usage

* Use ./mac for my mac

### Creating new packages

1. Copy .stow-local-ignore from an old package to the new one.
2. Populate README.md if applicable.
3. If setup commands are required, make an executable file in your package
   called setup. This will be ran by the installation commands above when this
   package is stowed.

