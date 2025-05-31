# 💾 Konfiguracja dysku dla NixOS

## 📋 Opis konfiguracji

Plik `disco.nix` zawiera kompletną konfigurację partycjonowania dysku dla NixOS przy użyciu narzędzia `disko`. Konfiguracja tworzy:

1. **Partycja ESP** (1 GiB)
   - Montowana jako `/boot`
   - System plików FAT32
   - Zabezpieczona uprawnieniami (tylko root)

2. **Vault** (20 GB)
   - Szyfrowany LUKS2
   - System plików BTRFS
   - Optymalna kompresja ZSTD
   - Wsparcie dla TRIM

3. **Swap** (34 GB)
   - Wsparcie dla hibernacji
   - Szyfrowanie losowym kluczem
   - Obsługa do 32 GB RAM

4. **Root** (reszta dysku)
   - System plików BTRFS
   - Subvolumes:
     - `@root` → `/`
     - `@home` → `/home`
     - `@nix` → `/nix`
     - `@persist` → `/persist`
     - `@snapshots` → `/.snapshots`
   - Optymalne opcje montowania
   - Kompresja ZSTD
   - Automatyczna defragmentacja

## 🛠️ Jak użyć

### 1. Instalacja disko

```bash
nix-shell -p disko
```

### 2. Przygotowanie konfiguracji

1. Skopiuj plik `disco.nix` do katalogu z konfiguracją NixOS
2. Dostosuj ścieżkę urządzenia (`/dev/nvme0n1`) do swojego systemu
3. Opcjonalnie dostosuj rozmiary partycji

### 3. Dodaj do configuration.nix

```nix
{ config, pkgs, ... }:
{
  imports = [
    ./disco.nix    # Import konfiguracji dysku
    ./hardware-configuration.nix
    # ... pozostałe importy
  ];
}
```

### 4. Zastosuj konfigurację

```bash
sudo nixos-rebuild switch
```

## ⚠️ Ważne uwagi

1. **BACKUP**: Wykonaj kopię zapasową danych przed użyciem!
2. **Sprawdź urządzenie**: Upewnij się, że wybrałeś właściwy dysk
3. **Rozmiar swap**: Dostosuj do ilości RAM w systemie
4. **LUKS**: Zapamiętaj hasło do vaulta!

## 🔧 Optymalizacje

- **Kompresja ZSTD**: Poziom 3 (dobry balans kompresja/wydajność)
- **Wydajność**: Włączone noatime, space_cache=v2
- **SSD**: Włączone TRIM i autodefrag
- **Bezpieczeństwo**: Szyfrowanie LUKS2 i swap

## 📚 Dodatkowe informacje

1. **Dokumentacja**:
   - [NixOS Disko](https://github.com/nix-community/disko)
   - [BTRFS Wiki](https://btrfs.wiki.kernel.org)
   - [LUKS Documentation](https://gitlab.com/cryptsetup/cryptsetup)

2. **Wsparcie**:
   - [NixOS Discourse](https://discourse.nixos.org)
   - [NixOS Matrix](https://matrix.to/#/#nixos:matrix.org)

## 🔍 Weryfikacja

Po instalacji możesz zweryfikować konfigurację:

```bash
# Sprawdź partycje
lsblk

# Sprawdź punkty montowania
mount | grep 'btrfs\|/boot'

# Sprawdź subvolumes BTRFS
sudo btrfs subvolume list /

# Sprawdź opcje montowania
cat /proc/mounts | grep 'btrfs\|/boot'
```

## 🔄 Aktualizacja

Aby zaktualizować konfigurację:

1. Edytuj `disco.nix`
2. Wykonaj `sudo nixos-rebuild switch`
3. Zweryfikuj zmiany

## ⚡ Wydajność

Ta konfiguracja została zoptymalizowana pod kątem:
- Szybkości odczytu/zapisu
- Wykorzystania SSD
- Kompresji danych
- Zarządzania pamięcią