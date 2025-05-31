# -----------------------------------------------------------------------------
# Hook: Automatyczne uruchomienie first-setup.sh przy pierwszym logowaniu usera
# Usuwa się sam po wykonaniu (tworzy flagę .first-setup-done)
# -----------------------------------------------------------------------------
if [ -f "$HOME/.local/bin/first-setup.sh" ] && [ ! -f "$HOME/.first-setup-done" ]; then
  bash "$HOME/.local/bin/first-setup.sh" && touch "$HOME/.first-setup-done"
fi
