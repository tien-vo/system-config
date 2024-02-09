{
  description = "Personal flake for system configurations";

  inputs = {
    nixpkgs = {
      url = "github:nixos/nixpkgs/nixos-unstable";
    };
    hardware = {
      url = "github:nixos/nixos-hardware";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-colors = {
      url = "github:misterio77/nix-colors";
    };
    hyprland = {
      url = "github:hyprwm/Hyprland";
    };
    flake-utils = {
      url = "github:numtide/flake-utils";
    };
    nix-ld-rs = {
      url = "github:nix-community/nix-ld-rs";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-utils.follows = "flake-utils";
    };
  };

  outputs = inputs:
    let
      args = {
        inherit inputs;
        inherit (inputs.self) outputs;
        settings = import (./settings) (inputs);
      };
      inherit (args.settings) src arch pkgs;
    in
    {
      formatter.${arch} = pkgs.nixpkgs-fmt;
      nixosConfigurations = {
        fw13 = inputs.nixpkgs.lib.nixosSystem ({
          inherit pkgs;
          modules = [ "${src}/systems/${arch}/fw13" ];
          specialArgs = args;
        });
      };
      homeConfigurations = {
        "tvo@fw13" = inputs.home-manager.lib.homeManagerConfiguration ({
          inherit pkgs;
          modules = [ "${src}/users/${arch}/tvo@fw13" ];
          extraSpecialArgs = args;
        });
      };
    };
}
