# Schemat docelowego systemu NixOS (styl Archcraft, użytkownik: ravert)

```plaintext
┌─────────────────────────────┐
│   Struktura dysku (BTRFS)  │
├─────────────────────────────┤
│ /dev/nvme0n1                │
│ ├─ /boot  (ESP, 1GB, vfat)  │
│ ├─ swap   (34GB, swap)      │
│ ├─ vault  (20GB, LUKS+BTRFS)│
│ └─ root   (reszta, BTRFS)   │
│                              │
│ BTRFS subvolumes:           │
│    @root      -> /          │
│    @home      -> /home      │
│    @nix       -> /nix       │
│    @persist   -> /persist   │
│    @snapshots -> /.snapshots│
└─────────────────────────────┘

┌────────────────────────────────────────────┐
│      Struktura katalogów usera: ravert     │
├────────────────────────────────────────────┤
│ /home/ravert/                              │
│ ├─ .config/                                │
│ │   ├─ openbox/ (rc.xml, autostart, menu...)│
│ │   ├─ polybar/ (config.ini, launch.sh)    │
│ │   ├─ rofi/   (motyw nordic, config)      │
│ │   ├─ picom/  (config, blur, shadows)     │
│ │   ├─ dunst/  (notyfikacje, styl nordic)  │
│ │   ├─ alacritty/ (motyw nordic)           │
│ ├─ .local/bin/ (mount-vault.sh, ...skrypty)│
│ └─ ...                                     │
└────────────────────────────────────────────┘

┌──────────────────────────────────────────┐
│            Środowisko graficzne         │
├──────────────────────────────────────────┤
│ Openbox (WM, motyw nordic, minimalistyczny)    │
│ Polybar (góra+dół, sekcje: CPU, RAM, 2xBat)   │
│ Rofi (launcher, motyw nordic)                 │
│ Picom (przezroczystości, blur, cienie)        │
│ Dunst (powiadomienia, styl nordic)            │
│ Alacritty (terminal, motyw nordic)            │
│ Ikony: Papirus/Nordic                         │
│ Czcionki: JetBrains Mono, Noto Sans, FA5      │
└──────────────────────────────────────────┘

┌──────────────────────────────────────────┐
│        Skrypty i automatyzacje           │
├──────────────────────────────────────────┤
│ .local/bin/mount-vault.sh     - montuje vault         │
│ .local/bin/umount-vault.sh    - odmontowuje vault     │
│ .local/bin/volume-control.sh  - reguluje dźwięk       │
│ .local/bin/brightness-control.sh - jasność            │
│ ... (możesz dodać własne)                             │
└──────────────────────────────────────────┘

┌──────────────────────────────────────────┐
│            System NixOS                  │
├──────────────────────────────────────────┤
│ Konfiguracja modularna (hardware, users, home-manager)│
│ Wszystko mocno skomentowane po polsku                │
│ Vault NIE montowany automatycznie!                   │
│ Szybka instalacja przez repozytorium (flake lub nixos-install) │
│ README.md z tabelą partycji, screenami, inspiracjami         │
└──────────────────────────────────────────┘
```

---

## Legenda:

- **Vault** – prywatna, szyfrowana partycja, montowana tylko na żądanie (skryptem, nigdy automatycznie!).
- **BTRFS** – system plików z subvolumes dla łatwych snapshotów i porządku.
- **Openbox + Polybar + Rofi + Picom + Dunst + Alacritty** – całość stylizowana na nordic/archcraft, z czytelnymi panelami i minimalizmem.
- **Wszystkie pliki konfiguracyjne i skrypty mają obszerne komentarze po polsku.**
- **Automatyzacja/instalacja przez GitHub (flake, README, workflow).**

---