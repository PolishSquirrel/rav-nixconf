# =============================================================================
# Plik: modules/template.nix
# -----------------------------------------------------------------------------
# SZABLON MODUŁU NIXOS Z OBSZERNYMI KOMENTARZAMI
#
# Instrukcja użycia:
# - Skopiuj ten plik do modules/<twoj-modul>.nix.
# - Wypełnij sekcje zgodnie z przeznaczeniem modułu.
# - Przeredaguj lub usuń sekcje, które nie są potrzebne.
#
# Zgodność: https://nixos.wiki/wiki/Module
# =============================================================================

{ config, pkgs, lib, ... }:

{
  # ---------------------------------------------------------------------------
  # [OPCJONALNIE] Import innych modułów lub przekazanie opcji
  # Jeśli Twój moduł wymaga opcji z innych miejsc, użyj imports = [ ... ];
  # ---------------------------------------------------------------------------
  # imports = [ ./some-other-module.nix ];

  # ---------------------------------------------------------------------------
  # [PRZYKŁAD] Sekcja konfiguracji pakietów systemowych
  # Dodaje wybrane pakiety do systemu (dostępne dla wszystkich użytkowników)
  # ---------------------------------------------------------------------------
  environment.systemPackages = with pkgs; [
    # wpisz tutaj pakiety, np. htop neofetch
  ];

  # ---------------------------------------------------------------------------
  # [PRZYKŁAD] Konfiguracja usług systemowych (systemd)
  # Włączanie i konfigurowanie usług NixOS (np. nginx, openssh, docker)
  # ---------------------------------------------------------------------------
  # services.nginx.enable = true;
  # services.openssh.enable = true;

  # ---------------------------------------------------------------------------
  # [PRZYKŁAD] Definicja użytkowników, grup, uprawnień (jeśli potrzebne)
  # https://nixos.wiki/wiki/Users_and_Groups
  # ---------------------------------------------------------------------------
  # users.users.nowyuzytkownik = {
  #   isNormalUser = true;
  #   extraGroups = [ "wheel" ];
  #   shell = pkgs.bash;
  # };

  # ---------------------------------------------------------------------------
  # [PRZYKŁAD] Dodawanie własnych skryptów do systemu
  # Skrypty mogą być instalowane jako pakiety lub w /etc
  # ---------------------------------------------------------------------------
  # environment.etc."mojskrypt.sh".text = ''
  #   #!/bin/sh
  #   echo "Witaj w moim skrypcie!"
  # '';

  # ---------------------------------------------------------------------------
  # [PRZYKŁAD] Konfiguracja usług użytkownika (Home Manager) – jeśli dotyczy
  # Tę sekcję dodawaj tylko jeśli Twój flake przekazuje home-manager.users.<user>
  # ---------------------------------------------------------------------------
  # home.file.".config/mojaplikacja/config.toml".text = ''
  #   [ustawienia]
  #   klucz = "wartość"
  # '';

  # ---------------------------------------------------------------------------
  # [PRZYKŁAD] Ustawienia specyficzne dla sprzętu lub środowiska
  # https://nixos.wiki/wiki/Hardware
  # ---------------------------------------------------------------------------
  # hardware.bluetooth.enable = true;

  # ---------------------------------------------------------------------------
  # [UWAGA] Zawsze kończ moduł nawiasem zamykającym!
  # ---------------------------------------------------------------------------
}