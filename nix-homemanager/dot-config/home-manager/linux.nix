# see: https://nixos-and-flakes.thiscute.world/nixos-with-flakes/modularize-the-configuration#lib-mkorder-lib-mkbefore-and-lib-mkafter

{
  config,
  pkgs,
  unstable-pkgs,
  machineArgs,
  ...
}: {
  home.packages = with pkgs; [
    clang
    libz
    cmake
    gdb
    gnumake
    gmp
    ncurses
    libclang
    valgrind
    nodejs
    jdk23
    parallel-full
    minizinc
    beets
    keychain
    xclip
    heaptrack
    massif-visualizer
    kdePackages.kcachegrind
    sccache
    yubikey-manager
  ];

  home.sessionVariables = with pkgs; {

    LIBCLANG_PATH = "${libclang.lib}/lib";

    # fix bindgen not finding stddef.h.

    # bindgen uses libclang to compile not $CC, so doesn't play nicely with how
    # nix overrides the compiler flags.

    # https://discourse.nixos.org/t/setting-up-a-nix-env-that-can-compile-c-libraries/15833/3
    BINDGEN_EXTRA_CLANG_ARGS="$(< ${stdenv.cc}/nix-support/libc-crt1-cflags) \
          $(< ${stdenv.cc}/nix-support/libc-cflags) \
          $(< ${stdenv.cc}/nix-support/cc-cflags) \
          $(< ${stdenv.cc}/nix-support/libcxx-cxxflags) \
          ${
            lib.optionalString stdenv.cc.isClang
            "-idirafter ${stdenv.cc.cc}/lib/clang/${
              lib.getVersion stdenv.cc.cc
            }/include"
          } \
          ${
            lib.optionalString stdenv.cc.isGNU
            "-isystem ${stdenv.cc.cc}/include/c++/${
              lib.getVersion stdenv.cc.cc
            } -isystem ${stdenv.cc.cc}/include/c++/${
              lib.getVersion stdenv.cc.cc
            }/${stdenv.hostPlatform.config} -idirafter ${stdenv.cc.cc}/lib/gcc/${stdenv.hostPlatform.config}/${
              lib.getVersion stdenv.cc.cc
            }/include"
          }";
  };

}
