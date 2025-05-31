#!/usr/bin/env bash
# -----------------------------------------------------------------------------
# Skrypt: install.sh
# Opis:  Automatyzuje cały proces wdrożenia modularnego NixOS z repozytorium git.
#         - Klonuje repozytorium z GitHub
#         - Montuje partycje (system, vault)
#         - Podmienia UUID vaulta i nazwę użytkownika wg parametrów/skanu
#         - Kopiuje configi oraz katalog home/
#         - Przebudowuje system przez flake
#         - Ustawia uprawnienia
#         - Dodaje hook do automatycznego setupu home przy pierwszym logowaniu
#         - (Opcjonalnie) Ustawia hasło użytkownika
# -----------------------------------------------------------------------------
# Przykład użycia:
#   bash install.sh --repo https://github.com/TWOJ_USER/nixos-t480-modular.git --user ravert --vault-uuid abcd-1234
# -----------------------------------------------------------------------------

set -e
set -u

# ------------------ PARAMETRY ------------------
REPO_URL=""
TARGET_USER=""
VAULT_UUID=""
BRANCH="main"

while [[ $# -gt 0 ]]; do
  case "$1" in
    --repo) REPO_URL="$2"; shift 2 ;;
    --user) TARGET_USER="$2"; shift 2 ;;
    --vault-uuid) VAULT_UUID="$2"; shift 2 ;;
    --branch) BRANCH="$2"; shift 2 ;;
    *) echo "Nieznany parametr: $1"; exit 1 ;;
  esac
done

if [[ -z "$REPO_URL" || -z "$TARGET_USER" || -z "$VAULT_UUID" ]]; then
  echo "Użycie: bash install.sh --repo <URL> --user <user> --vault-uuid <UUID> [--branch <branch>]"
  exit 1
fi

echo "🟦 Klonuję repozytorium: $REPO_URL (branch: $BRANCH)"
git clone --depth 1 --branch "$BRANCH" "$REPO_URL" /mnt/nixos-tmp

cd /mnt/nixos-tmp

# ------------------ PERSONALIZACJA ------------------
echo "🟦 Personalizuję UUID vaulta i nazwę użytkownika w konfiguracji..."

sed -i "s/VAULT_UUID_PLACEHOLDER/$VAULT_UUID/g" modules/vault.nix home/$TARGET_USER/.local/bin/mount-vault.sh
sed -i "s/ravert/$TARGET_USER/g" modules/users.nix home/$TARGET_USER/home.nix

# ------------------ KOPIOWANIE PLIKÓW ------------------
echo "📂 Kopiuję pliki konfiguracyjne do /etc/nixos/..."
cp -r hardware-configuration.nix configuration.nix flake.nix modules /etc/nixos/

echo "📂 Kopiuję katalog home/$TARGET_USER do katalogu domowego użytkownika..."
cp -r "home/$TARGET_USER" "/home/$TARGET_USER"
chown -R "$TARGET_USER":"$TARGET_USER" "/home/$TARGET_USER"

# ------------------ PRZEBUDOWA SYSTEMU ------------------
echo "✨ Przebudowuję system przez flake..."
nixos-rebuild switch --flake /etc/nixos#t480

# ------------------ USTAWIANIE UPRAWNIEŃ ------------------
echo "🔑 Nadaję prawa wykonywania skryptom użytkownika..."
chmod +x "/home/$TARGET_USER/.local/bin/"*

# ------------------ HOOK: AUTOMATYCZNY SETUP PO LOGOWANIU ------------------
# Tworzy hook, który przy pierwszym logowaniu wywoła first-setup.sh i automatycznie się usunie
echo "🔁 Dodaję hook do automatycznego setupu home po pierwszym logowaniu..."
cat << 'EOF' > "/home/$TARGET_USER/.profile"
if [ -f "$HOME/.local/bin/first-setup.sh" ] && [ ! -f "$HOME/.first-setup-done" ]; then
  bash "$HOME/.local/bin/first-setup.sh" && touch "$HOME/.first-setup-done"
fi
EOF
chown "$TARGET_USER":"$TARGET_USER" "/home/$TARGET_USER/.profile"

# ------------------ (OPCJONALNIE) USTAW HASŁO ------------------
echo "Możesz teraz ustawić hasło użytkownika: $TARGET_USER"
passwd "$TARGET_USER"

echo "✅ Instalacja zakończona! Po restarcie i pierwszym logowaniu środowisko zostanie automatycznie skonfigurowane."