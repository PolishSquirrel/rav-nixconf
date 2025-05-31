# =============================================================================
# Plik: flake.nix
# -----------------------------------------------------------------------------
# Główna deklaracja systemu NixOS, importująca partycjonowanie disco.nix
# oraz wszystkie modularne pliki konfiguracyjne.
# -----------------------------------------------------------------------------
# Dokumentacja: https://nixos.wiki/wiki/Flakes
# =============================================================================

{
  description = "Ravert - automatyczna, modularna konfiguracja NixOS z disko.";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
    flake-utils.url = "github:numtide/flake-utils";
    disko.url = "github:nix-community/disko";
    home-manager.url = "github:nix-community/home-manager/release-24.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, flake-utils, disko, home-manager, ... }@inputs:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };
      in
      {
        nixosConfigurations.t480 = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            disko.nixosModules.disko
            ./disco.nix
            ./modules/users.nix
            ./modules/desktop.nix
            ./modules/vault.nix
            ./modules/services.nix
            ./modules/optimize-thinkpad.nix
            ./modules/backup-btrbk.nix
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.ravert = import ./home/ravert.nix;
            }
          ];
        };
      }
    );
}