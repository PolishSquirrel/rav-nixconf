# CHECKLISTA – Modularny NixOS w stylu Archcraft (ThinkPad T480)

---

## 1. Podstawowa struktura systemu i modularność
- [x] Pliki: `hardware-configuration.nix`, `configuration.nix`, katalog `modules/` z podmodułami
- [x] Każdy moduł (users, desktop, vault, optimize-thinkpad, services) jest osobnym, sprawdzonym plikiem
- [x] Główny plik `configuration.nix` importuje wszystkie moduły – **sprawdzone pod kątem składni**

---

## 2. Użytkownik i bezpieczeństwo
- [x] Użytkownik główny (np. ravert) skonfigurowany, shell, grupy, sudo, root zablokowany
- [x] `users.mutableUsers = false` (zarządzanie tylko przez plik)
- [ ] Hasło użytkownika ustawione (w pliku lub po instalacji przez `passwd`)
- [x] Sprawdzone, czy nie ma duplikacji/grup z innych plików

---

## 3. Sprzęt, partycje i sterowniki
- [x] Plik `hardware-configuration.nix` poprawny, UUID oraz subvolumes zgodne z rzeczywistością
- [x] Mikrokod CPU, firmware, sterowniki Intel włączone w optimize-thinkpad.nix
- [x] Swap skonfigurowany
- [x] Składnia i opcje zweryfikowane z wiki

---

## 4. Szyfrowany vault (LUKS + BTRFS)
- [x] Moduł vault.nix poprawnie skonfigurowany (UUID, brak automount)
- [x] Zgodność z wiki (https://nixos.wiki/wiki/Dm-crypt)
- [ ] Skrypt do ręcznego montowania vaulta (np. ~/.local/bin/mount-vault.sh) utworzony, przetestowany

---

## 5. Desktop w stylu Archcraft (Openbox, Polybar, Rofi, Picom itd.)
- [x] Moduł desktop.nix: Openbox, Polybar, motywy nordic/adi1090x, Papirus, DMZ, Home Manager – wszystko modularnie i poprawnie
- [ ] Pliki konfiguracyjne do:  
  - [ ] Openbox (`~/.config/openbox/rc.xml`, `menu.xml`)
  - [ ] Polybar (`~/.config/polybar/config`)
  - [ ] Rofi (`~/.config/rofi/config`)
  - [ ] Dunst (`~/.config/dunst/dunstrc`)
  - [ ] Picom (`~/.config/picom.conf`)
  - [ ] Alacritty (`~/.config/alacritty/alacritty.yml`)
- [ ] Motyw SDDM (np. nordic/adw-gtk3) skopiowany i wskazany w konfiguracji
- [ ] Tapety w stylu Archcraft w katalogu użytkownika (`~/Pictures/Wallpapers`)
- [ ] Fonty (np. JetBrainsMono, FontAwesome, Meslo) zainstalowane systemowo lub przez Home Manager
- [ ] Autostart aplikacji (np. Polybar, Picom, feh, dunst) wpisany do `~/.config/openbox/autostart`

---

## 6. Home Manager – pełna konfiguracja użytkownika
- [x] Home Manager włączony przez system (programs.home-manager.enable)
- [ ] Utworzony katalog `home/ravert/` oraz plik `home.nix` z importem configów aplikacji
- [ ] Symlinki albo kopie configów (z Archcraft/Adi1090x) do `~/.config/`
- [ ] Dodatkowe aliasy, ustawienia shell i zmienne środowiskowe (opcjonalnie)

---

## 7. Optymalizacja ThinkPad T480
- [x] TLP, Thinkfan, tpacpi-bat, fprintd, ACPI, powertop, brightnessctl, lm_sensors, itd. – moduł optimize-thinkpad.nix
- [x] Sprawdzone zgodność i brak duplikacji z desktop/services
- [x] Zgodność z wiki ThinkPad i praktyką społeczności

---

## 8. Usługi systemowe
- [x] NetworkManager, firewall, Bluetooth, blueman, printing (cups, avahi, hplip, gutenprint), timesyncd, udisks2, gvfs, upower, flatpak – moduł services.nix
- [x] Składnia i logika sprawdzone z wiki
- [ ] (opcjonalnie) SSH, autoUpgrade – zakomentowane, gotowe do aktywacji

---

## 9. README i dokumentacja
- [x] README.md w repozytorium – opisuje strukturę, inspiracje, instalację, FAQ
- [x] Komentarze po polsku oraz odwołania do wiki w każdym pliku
- [x] Checklisty, instrukcje, ostrzeżenia

---

## 10. Testy i weryfikacja końcowa
- [x] Każdy plik zweryfikowany pod względem składni i logiki (nix-instantiate, dry-run, ręczna kontrola)
- [x] Brak powielania ustawień i konfliktów
- [x] Zgodność z dokumentacją i wiki

---

## CO JESZCZE ZROBIĆ (by mieć pełne „Archcraft experience”):

- [ ] Uzupełnić, skopiować lub napisać własne pliki konfiguracyjne Openbox, Polybar, Rofi, Picom, Dunst, Alacritty (najlepiej na bazie Archcraft/Adi1090x)
- [ ] Skonfigurować home-manager/home.nix oraz symlinki do tych configów
- [ ] Wgrać tapety, fonty i themes
- [ ] Dodać/przetestować skrypt do montowania vaulta
- [ ] Przetestować autostart, skróty klawiszowe, powiadomienia, rofi, menu Openbox itd.
- [ ] Dodać do README sekcje: „Pierwsze uruchomienie”, „FAQ”, „Troubleshooting”

---

**Sugestia kolejnego kroku**:  
Uzupełnić katalog `home/ravert/` o plik `home.nix` i wybrane configi (Openbox, Polybar, itd.)  
Chcesz, abym wygenerował przykładowy `home.nix` i stylizowane confy na bazie Archcraft?