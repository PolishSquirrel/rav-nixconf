# =============================================================================
# Plik: configuration.nix
# -----------------------------------------------------------------------------
# Główna konfiguracja systemu NixOS
# -----------------------------------------------------------------------------
# Ten plik jest centralnym punktem modularnej konfiguracji.
# Importuje poszczególne moduły, dzięki czemu konfiguracja jest przejrzysta,
# łatwa w utrzymaniu, rozbudowie i przenoszeniu na inne maszyny.
# 
# Każdy plik/moduł odpowiada za konkretną funkcjonalność lub aspekt systemu:
#   - hardware-configuration.nix: sprzęt, partycje, dyski, sterowniki
#   - users.nix: użytkownik główny, sudo, shell, bezpieczeństwo
#   - desktop.nix: środowisko graficzne, pakiety desktopowe, fonty
#   - vault.nix: szyfrowany vault (LUKS+BTRFS), bezpieczeństwo danych
#   - optimize-thinkpad.nix: optymalizacje pod ThinkPad (TLP, wentylator, Thunderbolt itp.)
#   - services.nix: usługi systemowe (sieć, bluetooth, drukarki, firewall, Flatpak itd.)
#   - backup-btrbk.nix: automatyczny backup vaulta z retencją
#
# Edytuj ten plik tylko wtedy, gdy chcesz zmienić podstawowe ustawienia systemu
# lub dodać nowy moduł (import).
#
# Dokumentacja:
#   - https://nixos.org/manual/nixos/stable/index.html#sec-configuration-file
#   - https://nixos.wiki/wiki/NixOS_Modules
#   - https://nixos.wiki/wiki/Configuration_Collection
# =============================================================================

{ config, pkgs, ... }:

{
  # ===========================================================================
  # IMPORT MODUŁÓW KONFIGURACYJNYCH
  # ---------------------------------------------------------------------------
  # Każdy plik importowany poniżej odpowiada za osobną sekcję systemu.
  # Dzięki temu całość jest czytelna i łatwa do rozbudowy.
  # ===========================================================================
  imports =
    [
      # Konfiguracja sprzętu i partycji (wygenerowany automatycznie, NIE edytuj ręcznie!)
      ./hardware-configuration.nix

      # Konfiguracja użytkownika głównego, shell, sudo, locale, blokada root
      ./modules/users.nix

      # Środowisko graficzne: Openbox, Polybar, Picom, motywy, fonty, aplikacje desktopowe
      ./modules/desktop.nix

      # Konfiguracja zaszyfrowanego vaulta (LUKS+BTRFS), bezpieczeństwo danych
      ./modules/vault.nix

      # Optymalizacje dla ThinkPad T480: zarządzanie energią, wentylator, Thunderbolt, fingerprint
      ./modules/optimize-thinkpad.nix

      # Usługi systemowe: sieć, firewall, bluetooth, drukarki, upower, avahi, Flatpak itd.
      ./modules/services.nix

      # Automatyczny backup vaulta (btrbk), retencja snapshotów
      ./modules/backup-btrbk.nix
    ];

  # ===========================================================================
  # PODSTAWOWE USTAWIENIA SYSTEMOWE
  # ---------------------------------------------------------------------------
  # system.stateVersion:
  #   - Określa wersję, od której system powinien zachowywać kompatybilność.
  #   - NIE aktualizuj jej bez powodu – zmień tylko przy przejściu na nową wersję NixOS!
  #   - Sprawdź swoją wersję poleceniem: `nixos-version`
  # ===========================================================================
  system.stateVersion = "24.05"; # <--- Ustaw na wersję odpowiadającą twojemu systemowi, np. "24.05"

  # ===========================================================================
  # DODATKOWE USTAWIENIA (opcjonalnie)
  # ---------------------------------------------------------------------------
  # Tu możesz dodać własne globalne ustawienia systemowe, jeśli będą potrzebne
  # np. timezone, ntp, locale, custom services (lepiej jednak robić to modularnie)
  # ===========================================================================
  # Example:
  # time.timeZone = "Europe/Warsaw";
}