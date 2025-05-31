# -----------------------------------------------------------------------------
# Plik: modules/services.nix
# Konfiguracja usług systemowych: sieć, firewall, bluetooth, drukarka, avahi, upower, flatpak
# -----------------------------------------------------------------------------

{ config, pkgs, ... }:

{
  networking.networkmanager.enable = true;
  networking.firewall.enable = true;

  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;

  services.printing.enable = true;
  services.avahi.enable = true;
  services.upower.enable = true;

  services.flatpak.enable = true;

  # Synchronizacja czasu
  services.timesyncd.enable = true;

  # Udisks2 (auto-mount USB)
  services.udisks2.enable = true;
}