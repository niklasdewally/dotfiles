# todo list and development notes

## Goals

- Simple implementation: does exactly what I need it to, and nothing more.
  + Previous systems I used (cough nix) had far too many features. As I only
    edit dotfiles occasionally, this meant that I had to spend time relearning
    what my config did before I could edit it.

- Portability: the core framework should be usable on work devices and different
  OSs without a lot of dependency installation.
    + e.g. mostly written in standard bash shell, few external dependencies
      (just GNU stow?)

- Extensible: work configuration to be stored in its own repo which pulls from
  this one as a submodule, stored on work servers.

- Manage config for multiple devices with different OSs and CPU architectures:
   + Apple Silicon Macs
   + x86 Linux (Ubuntu)
   + Shared config for some apps, 

- Manage the symlinking of config files as well as allowing the execution of
  post-installation hooks in any language for a given package.

### Antigoals

- Full determinism / infrastructure as code (e.g. nix); the ability to setup an
  entire machine from scratch just using this configuration.
- Configuration management and development environment setup on servers / AWS
  instances: I have my own system for these.

- No oversharing of configs.

  In my current setup, I have a folder called common/ with a lot of configs that
  are meant to be for all devices. On many of my devices, these are actually
  modified on the local working tree, meaning that they are shared in prinicple
  but not in practice.  When adding dotfiles, start with these being device
  specific even if it seems sensible to share them. Share them once there is a
  real need to.  Sharing and mixing shared and unshared parts of a config file
  (e.g. by including a config.local file) adds complexity.

## Proposed design

Use GNU Stow to manage linking of configuration files. Have a folder of stow
packages for different apps and devices (allowing app specific configs to be
shared between devices). Each of these contains a post-installation hook script.

Either:

1. have a file called `setup` that is ignored by stow, but is used by a wrapper
  script during installation.

2. Have install scripts be uniquely named `~/.bin/install-scripts/<pkg>` which
   are installed by stow.

With the former, we need to know which packages are stowed inorder to run the
right installation scripts -  with the latter, we just run all currently
installed install scripts. These files can also act as a simple list of which
packages we actually have stowed. If we don't have this, we will have to keep a
manifest of which packages to install on which devices somewhere?



<!-- vim: cc=80 tw=80
-->
