{
  description = "NixOS Modularny, ThinkPad T480, Home Manager, btrbk, styl archcraft/adi1090x";

  # Zależności flake – oficjalne, stabilne kanały NixOS i Home Manager
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
    home-manager.url = "github:nix-community/home-manager/release-24.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs:
    let
      # Architektura systemu – zmień na arm64-linux jeśli używasz ARM
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; config.allowUnfree = true; };
    in {
      nixosConfigurations.t480 = nixpkgs.lib.nixosSystem {
        system = system;
        modules = [
          ./hardware-configuration.nix
          ./configuration.nix
          ./modules/users.nix
          ./modules/desktop.nix
          ./modules/vault.nix
          ./modules/optimize-thinkpad.nix
          ./modules/services.nix
          ./modules/backup-btrbk.nix
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.ravert = import ./home/ravert/home.nix;
          }
        ];
      };
    };
}