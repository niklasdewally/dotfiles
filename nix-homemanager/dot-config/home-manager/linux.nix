# see: https://nixos-and-flakes.thiscute.world/nixos-with-flakes/modularize-the-configuration#lib-mkorder-lib-mkbefore-and-lib-mkafter

{
  config,
  pkgs,
  unstable-pkgs,
  machineArgs,
  ...
}: {
  home.packages = [
    pkgs.valgrind
    pkgs.gdb
  ];
}
