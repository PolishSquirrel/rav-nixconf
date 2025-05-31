# =============================================================================
# Plik: modules/vault.nix
# -----------------------------------------------------------------------------
# Konfiguracja zaszyfrowanego vaulta (LUKS + BTRFS)
# UUID jest automatycznie podmieniany przez install.sh
# =============================================================================

{ config, pkgs, ... }:

{
  boot.initrd.luks.devices.vault = {
    device = "/dev/disk/by-uuid/VAULT_UUID_PLACEHOLDER";  # <-- Automatycznie podmieniany przez install.sh!
    preLVM = true;
    allowDiscards = true;
  };

  # Przykład: nie montuj automatycznie, tylko ręcznie po odblokowaniu vaulta
  # fileSystems."/vault" = {
  #   device = "/dev/mapper/vault";
  #   fsType = "btrfs";
  #   options = [ "subvol=@vault" ];
  #   noCheck = true;
  #   neededForBoot = false;
  # };
}