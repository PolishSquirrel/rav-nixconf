# NixOS Modularny – Checklista wdrożenia i utrzymania

## Legenda
- [x] – zadanie wykonane i sprawdzone
- [ ] – zadanie do wykonania
- [o] – zadanie częściowo wykonane/w trakcie (zostaw notatkę niżej)

---

## 1. Podstawy systemu

- [ ] Przygotowanie partycji: system, swap, vault (LUKS+BTRFS)
- [ ] Wygenerowanie hardware-configuration.nix przez `nixos-generate-config`
- [ ] Sprawdzenie UUID partycji w plikach konfiguracyjnych

---

## 2. Struktura repozytorium

- [ ] Utworzenie katalogów: `modules/`, `home/`, `home/ravert/.config/`, etc.
- [ ] Umieszczenie plików: flake.nix, configuration.nix, hardware-configuration.nix, README.md, CHECKLIST.md

---

## 3. System modularny (pliki NixOS)

- [ ] `modules/users.nix` – konfiguracja użytkownika, sudo, shell, blokada root
- [ ] `modules/desktop.nix` – Openbox, Polybar, Rofi, Picom, motywy, Home Manager
- [ ] `modules/vault.nix` – vault LUKS+BTRFS, bez auto-mount
- [ ] `modules/optimize-thinkpad.nix` – power, TLP, thinkfan, Thunderbolt, fingerprint, jasność
- [ ] `modules/services.nix` – sieć, firewall, bluetooth, drukarki, upower, avahi, flatpak
- [ ] `modules/backup-btrbk.nix` – tygodniowy backup, retencja 45 dni

---

## 4. Home Manager

- [ ] `home/ravert/home.nix` – pełna lista pakietów, aliasy, symlinki do configów, wszystkie usługi, motywy, fonty, autostart, Flatpak, gammastep, syncthing, dunst

---

## 5. Pliki konfiguracyjne środowiska

- [ ] `~/.config/openbox/rc.xml` – pełny, z komentarzami
- [ ] `~/.config/openbox/menu.xml` – pełny, z komentarzami
- [ ] `~/.config/openbox/autostart` – pełny, z komentarzami
- [ ] `~/.config/polybar/config` – pełny, z komentarzami
- [ ] `~/.config/picom.conf` – pełny, z komentarzami
- [ ] `~/.config/rofi/config` – pełny, z komentarzami
- [ ] `~/.config/dunst/dunstrc` – pełny, z komentarzami
- [ ] `~/.config/alacritty/alacritty.yml` – pełny, z komentarzami

---

## 6. Skrypty

- [ ] `~/.local/bin/first-setup.sh` – pełny, z komentarzami, automatyzacja setupu
- [ ] `~/.local/bin/mount-vault.sh` – pełny, z komentarzami, bezpieczny (status/mount/umount)

---

## 7. Automatyzacja, flake, backup

- [ ] Flake (`flake.nix`) – pełny, modularny, z Home Managerem
- [ ] Skrypt instalacyjny (`install.sh`) – pełna automatyzacja „git clone & switch”
- [ ] Hook `.profile` do automatycznego setupu home po pierwszym logowaniu
- [ ] Sprawdzenie i test backupu btrbk (ręcznie i przez systemd)

---

## 8. Dokumentacja i bezpieczeństwo

- [ ] README.md – pełny, z opisem każdego kroku i FAQ
- [ ] CHECKLIST.md – aktualizowana checklista
- [ ] AUDIT_PROCESS.md – dziennik sprawdzania, źródła, notatki audytowe
- [ ] Test skuteczności blokady root/sudo
- [ ] Test poprawności plików, braku skrótów (porównanie z wiki i poradnikami)
- [ ] Test działania systemu po klonowaniu z GitHub-a

---

## 9. Dodatki (opcjonalnie, dla własnych potrzeb)

- [ ] Backup/restore snapshotów ręcznie
- [ ] Dodanie kolejnych users/konfiguracji (np. dla innego sprzętu)
- [ ] Integracja z git (wersjonowanie home/config)
- [ ] Rozszerzenie na Wayland/i3/sway

---

## Notatki własne

- Tu zostawiaj opis co wymaga poprawki, co sprawdzić, co już zrobione częściowo

---
