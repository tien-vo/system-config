{
  description = "Personal flake for system configurations";

  inputs = {
    nixpkgs = {
      url = "github:nixos/nixpkgs/nixos-unstable";
    };
    nixpkgs-micromamba = {
      url = "github:nixos/nixpkgs/bbcc95ec1c749e487c4bbc4cf99ad52785c8cc7d";
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
    nixgl = {
      url = "github:nix-community/nixGL";
    };
    flake-utils = {
      url = "github:numtide/flake-utils";
    };
    nix-ld-rs = {
      url = "github:nix-community/nix-ld-rs";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-utils.follows = "flake-utils";
    };
    obsidian-plugins = {
      url = "github:cjavad/nixpille-obsidian-community-plugins";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
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
          modules = [
            inputs.sops-nix.homeManagerModules.sops
            "${src}/users/${arch}/tvo@fw13"
          ];
          extraSpecialArgs = args;
        });
      };
    };
}
