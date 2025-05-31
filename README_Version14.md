# Automatyczna modularna instalacja NixOS z partycjonowaniem przez disko

## ⚡ Szybki start (NixOS LiveCD)

**OSTRZEŻENIE: Ten proces USUNIE CAŁY DYSK! Używaj tylko na nowym sprzęcie lub po backupie!**

1. Uruchom komputer z NixOS LiveCD (najlepiej najnowszy obraz stable).
2. Połącz się z siecią (np. przez `nmtui`).
3. Sklonuj repozytorium i uruchom instalator:
   ```sh
   git clone https://github.com/PolishSquirrel/rav-nixconf.git
   cd rav-nixconf
   chmod +x install.sh
   sudo ./install.sh
   ```
4. Po instalacji zrestartuj komputer i **ustaw hasło użytkownika poleceniem `passwd`**.

## ✨ Co robi skrypt?
- Automatycznie partycjonuje i formatuje dysk przez [disko](https://nixos.wiki/wiki/Disko) zgodnie z `disco.nix`
- Klonuje repozytorium z modularnymi plikami NixOS (flake + modules)
- Generuje hardware-configuration.nix
- Automatycznie wykrywa i podmienia UUID vaulta w konfiguracji
- Instaluje system z pełną integracją Home Managera

## 🛡️ Dostosowanie
- Zmień zmienne w `install.sh` (`DISK`, `HOSTNAME`, `USERNAME`, `REPO_URL`) pod swój sprzęt
- W razie innego układu partycji, edytuj `disco.nix`
- Możesz dołożyć własne moduły do katalogu `modules/` lub użytkownika do `home/`

## Dokumentacja
- [NixOS Wiki: Disko](https://nixos.wiki/wiki/Disko)
- [NixOS Wiki: Flakes](https://nixos.wiki/wiki/Flakes)
- [NixOS Wiki: Home Manager](https://nixos.wiki/wiki/Home_Manager)
