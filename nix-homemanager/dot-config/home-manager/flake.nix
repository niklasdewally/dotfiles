{
  description = "Home Manager configuration of niklas";

  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    nixpkgs,
    nixpkgs-unstable,
    home-manager,
    ...
  }:
  # see : https://github.com/jonringer/nixpkgs-config/blob/618496e858af54f1b6deab4747bded0e11c60204/flake.nix
  # see : https://github.com/Misterio77/nix-starter-configs/blob/main/standard/flake.nix
  let
    mkHomeConfiguration = {
      system, # system type e.g. x86_64-linux, aarch64-darwin
      username, # e.g. niklas,nik
      hostname, # the short or long hostname of the machine : e.g. cau.dewally.com, cau
      homeDirectory, # e.g. /home/niklas
      extraModules ? [], # extra, host specific, home-manager modules to include
    } @ machineArgs:
      home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.${system};

        # Specify your home configuration modules here, for example,
        # the path to your home.nix.
        modules = [./home.nix] ++ extraModules;

        # Optionally use extraSpecialArgs
        # to pass through arguments to home.nix
        extraSpecialArgs = {
          inherit machineArgs;
          unstable-pkgs = nixpkgs-unstable.legacyPackages.${system};
        };
      };

    systems = ["x86_64-linux" "aarch64-darwin"];

    # This is a function that generates an attribute by calling a function you
    # pass to it, with each system as an argument
    forAllSystems = nixpkgs.lib.genAttrs systems;
  in {
    # if the config name is "username@hostname", home-manager will automatically run the right config for each device.
    homeConfigurations."nik@cau" = mkHomeConfiguration {
      system = "x86_64-linux";
      username = "nik";
      hostname = "cau.dewally.com";
      homeDirectory = "/home/nik";
      extraModules = [./linux.nix];
    };

    homeConfigurations."niklas@niklas-air" = mkHomeConfiguration {
      system = "aarch64-darwin";
      username = "niklas";
      hostname = "niklas-air";
      homeDirectory = "/Users/niklas";
    };

    # Formatter for your nix files, available through 'nix fmt'
    # Other options beside 'alejandra' include 'nixpkgs-fmt'
    formatter = forAllSystems (system: nixpkgs.legacyPackages.${system}.alejandra);
  };
}
