{
  # ...
  outputs = { self, nixpkgs, ... }@inputs: {
    nixosConfigurations.t480 = nixpkgs.lib.nixosSystem {
      # ...
      modules = [
        ./disco.nix      # <-- tu importujesz swój plik partycjonowania!
        ./modules/users.nix
        ./modules/desktop.nix
        ./modules/vault.nix
        ./modules/services.nix
        ./modules/optimize-thinkpad.nix
        ./modules/backup-btrbk.nix
        # ... inne moduły
      ];
    };
  };
}