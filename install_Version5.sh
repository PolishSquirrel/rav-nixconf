#!/usr/bin/env bash
# =============================================================================
# Skrypt: install.sh
# -----------------------------------------------------------------------------
# Automatyczna instalacja NixOS z repozytorium i partycjonowaniem przez disko!
# - Wykonuje partycjonowanie i formatowanie przez disko.nix
# - Klonuje repozytorium z konfiguracją (flake, modules/ itd.)
# - Generuje hardware-configuration.nix
# - Automatycznie ustawia UUID vaulta w module vault.nix
# - Instaluje system z flake
#
# UWAGA: Skrypt USUNIE CAŁY DYSK! Przetestuj na VM lub zrób backup!
# -----------------------------------------------------------------------------
# Wymagania:
# - NixOS LiveCD z dostępem do Internetu i zainstalowanym git, nix
# - Plik disco.nix w Twoim repozytorium (standard flake!)
# - Dostosuj zmienne na początku skryptu do swojego sprzętu!
# =============================================================================

set -euo pipefail

# -------------------------- KONFIGURACJA UŻYTKOWNIKA -------------------------
DISK="/dev/nvme0n1"                   # Główny dysk systemowy (jak w disco.nix)
HOSTNAME="t480"                        # Nazwa hosta (jak w flake)
USERNAME="ravert"                      # Nazwa użytkownika systemowego
REPO_URL="https://github.com/PolishSquirrel/rav-nixconf.git"  # Twoje repo
MNT="/mnt"

# -------------------------- KROK 1: POTWIERDZENIE ----------------------------
echo "UWAGA: Ten skrypt USUNIE WSZYSTKO z dysku $DISK!"
read -r -p "Czy na pewno chcesz kontynuować? (y/N): " CONFIRM
[[ "$CONFIRM" =~ ^[Yy]$ ]] || exit 1

# -------------------------- KROK 2: PRZYGOTOWANIE SYSTEMU --------------------
echo "Przygotowanie środowiska LiveCD..."
nix-env -iA nixos.git nixos.nixFlakes nixos.curl nixos.btrfs-progs nixos.util-linux nixos.lvm2 nixos.gptfdisk nixos.parted nixos.cryptsetup nixos.nix nixos.btrfs-progs nixos.nixfmt nixos.jq nixos.e2fsprogs --quiet

# -------------------------- KROK 3: KLONOWANIE REPOZYTORIUM ------------------
echo "Klonowanie repozytorium $REPO_URL..."
git clone "$REPO_URL" /mnt/etc/nixos

# -------------------------- KROK 4: WYWOŁANIE DISKO --------------------------
echo "Partyjconowanie i formatowanie dysku przez disko..."
nix run github:nix-community/disko -- --mode disko /mnt/etc/nixos/disco.nix

# -------------------------- KROK 5: MONTAŻ SYSTEMU ---------------------------
echo "Montowanie partycji (automatycznie przez disko)..."
# Disko automatycznie montuje wszystko pod /mnt!

# -------------------------- KROK 6: GENEROWANIE HARDWARE-CONFIG --------------
echo "Generowanie hardware-configuration.nix..."
nixos-generate-config --root /mnt

# -------------------------- KROK 7: AUTOMATYCZNA PODMIANA UUID VAULTA --------
echo "Wykrywanie UUID partycji vault z disco.nix..."
# Odczyt z pliku disco.nix (parsuje nazwę partycji vault i znajduje jej UUID)
VAULT_PART="$(lsblk -o NAME,SIZE,TYPE,MOUNTPOINT | grep '20G' | grep part | awk '{print "/dev/"$1}')"
if [ -z "$VAULT_PART" ]; then
  echo "Nie wykryto partycji vault! Sprawdź disco.nix i lsblk."
  exit 1
fi
VAULT_UUID=$(blkid -o value -s UUID $VAULT_PART)
echo "UUID vaulta: $VAULT_UUID"
sed -i "s/VAULT_UUID_PLACEHOLDER/$VAULT_UUID/" /mnt/etc/nixos/modules/vault.nix

# -------------------------- KROK 8: INSTALACJA SYSTEMU Z FLAKE ---------------
echo "Instalacja systemu NixOS z flake..."
nixos-install --flake /etc/nixos#$HOSTNAME --no-root-passwd

echo "INSTALACJA ZAKOŃCZONA! Po restarcie zaloguj się jako $USERNAME i ustaw hasło."