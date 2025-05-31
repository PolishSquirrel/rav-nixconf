# -----------------------------------------------------------------------------
# Plik: modules/users.nix
# Konfiguracja użytkownika systemowego oraz sudo/root
# -----------------------------------------------------------------------------

{ config, pkgs, ... }:

{
  users.users.ravert = {
    isNormalUser = true;
    description = "Ravert";
    extraGroups = [ "wheel" "networkmanager" "video" "audio" "lp" "scanner" "input" ];
    shell = pkgs.zsh;
    home = "/home/ravert";
  };

  # Blokada konta root (zgodnie z NixOS security best practices)
  users.users.root.hashedPassword = "!";

  # Sudo tylko dla wheel
  security.sudo.enable = true;
  security.sudo.wheelNeedsPassword = true;

  # Opcjonalnie: domyślna lokalizacja, język
  i18n.defaultLocale = "pl_PL.UTF-8";
  console.keyMap = "pl";
}