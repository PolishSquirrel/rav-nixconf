#!/usr/bin/env bash
# =============================================================================
# Automatyczna instalacja NixOS z wykorzystaniem disko, flake, vault oraz modularnych konfiguracji.
# -----------------------------------------------------------------------------
# Skrypt przeprowadza przez cały proces, NIE wymaga ręcznej interwencji poza ustawieniem hasła po restarcie.
# -----------------------------------------------------------------------------
# UWAGA: Skrypt USUWA WSZYSTKO Z DYSKU! Używaj odpowiedzialnie!
# Zalecane: najpierw test na VM lub backup sprzętu.
# =============================================================================

set -euo pipefail

# ----------- ZMODYFIKUJ TE ZMIENNE DO SWOJEGO SPRZĘTU I KONFIGURACJI ---------
DISK="/dev/nvme0n1"
HOSTNAME="t480"
USERNAME="ravert"
REPO_URL="https://github.com/PolishSquirrel/rav-nixconf.git"
MNT="/mnt"

echo "UWAGA: Ten skrypt USUNIE WSZYSTKO z dysku $DISK!"
read -r -p "Czy na pewno chcesz kontynuować? (y/N): " CONFIRM
[[ "$CONFIRM" =~ ^[Yy]$ ]] || exit 1

# --- 1. Instalacja niezbędnych narzędzi (jeśli nie są dostępne na LiveCD) ---
echo "Instalacja wymaganych narzędzi..."
nix-env -iA nixos.git nixos.nixFlakes nixos.curl nixos.btrfs-progs nixos.util-linux nixos.lvm2 nixos.gptfdisk nixos.parted nixos.cryptsetup nixos.jq nixos.e2fsprogs --quiet

# --- 2. Klonowanie repozytorium do /mnt/etc/nixos ---
echo "Klonowanie repozytorium $REPO_URL..."
mkdir -p $MNT/etc
git clone "$REPO_URL" $MNT/etc/nixos

# --- 3. Partycjonowanie i formatowanie przez disko ---
echo "Partyjconowanie i formatowanie dysku za pomocą disko..."
nix run github:nix-community/disko -- --mode disko $MNT/etc/nixos/disco.nix

# --- 4. hardware-configuration.nix ---
echo "Generowanie hardware-configuration.nix..."
nixos-generate-config --root $MNT

# --- 5. Automatyczna podmiana UUID vaulta ---
echo "Automatyczne wykrywanie partycji vault i podmiana UUID w konfiguracji..."
VAULT_PART="$(lsblk -o NAME,SIZE,TYPE | grep '20G' | grep part | awk '{print "/dev/"$1}' | head -n1)"
if [ -z "$VAULT_PART" ]; then
  echo "Nie wykryto partycji vault! Sprawdź disco.nix i partycjonowanie."
  exit 1
fi
VAULT_UUID=$(blkid -o value -s UUID $VAULT_PART)
echo "UUID vaulta: $VAULT_UUID"
sed -i "s/VAULT_UUID_PLACEHOLDER/$VAULT_UUID/" $MNT/etc/nixos/modules/vault.nix

# --- 6. Instalacja systemu z flake ---
echo "Instalacja NixOS z flake..."
nixos-install --flake /etc/nixos#$HOSTNAME --no-root-passwd

echo "INSTALACJA ZAKOŃCZONA! Po restarcie zaloguj się jako $USERNAME i ustaw hasło poleceniem: passwd"