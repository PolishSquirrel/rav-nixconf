# -----------------------------------------------------------------------------
# Plik: modules/vault.nix
# Konfiguracja zaszyfrowanego vaulta (LUKS+BTRFS) – zgodnie z https://nixos.wiki/wiki/Dm-crypt
# UWAGA: Vault nie jest montowany automatycznie!
# -----------------------------------------------------------------------------

{ config, pkgs, ... }:

{
  boot.initrd.luks.devices.vault = {
    device = "/dev/disk/by-uuid/VAULT_UUID_PLACEHOLDER";  # <-- Uzupełnij UUID!
    preLVM = true;
    allowDiscards = true;
  };

  # Przykład: brak automount vaulta w fileSystems!
  # fileSystems."/vault" = {
  #   device = "/dev/mapper/vault";
  #   fsType = "btrfs";
  #   options = [ "subvol=@vault" ];
  #   noCheck = true;
  #   neededForBoot = false;
  # };
}