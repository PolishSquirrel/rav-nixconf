## Automatyczne wdrożenie z GitHub-a (pełna automatyzacja "git clone & deploy")

**Wersja dla profesjonalistów** – cały system zaciągniesz i odpalisz jednym poleceniem!

### Krok 1. Uruchom Live ISO lub (jeśli to reinstalacja) zaloguj się na użytkownika root.

### Krok 2. Przygotuj partycje, zamontuj system i vault, ustaw sieć.

### Krok 3. Uruchom instalator (skrypt), podając repo, użytkownika i UUID vaulta:
```sh
bash <(curl -fsSL [https://github.com/PolishSquirrel/rav-nixconf/blob/600f9f77e1b5ad7779347da97785e6e8ad0c395b/install.sh] \
     --repo https://github.com/PolishSquirrel/rav-nixconf.git \
     --user ravert \
     --vault-uuid abcd-1234-efgh-9876
```
*(Podmień nazwy na swoje!)*

### Krok 4. Po restarcie i pierwszym logowaniu użytkownika całość środowiska, backup, configi, home zostaną skonfigurowane automatycznie.

---

**Możesz aktualizować system i home przez git pull + nixos-rebuild switch --flake .#t480.  
Całość w pełni powtarzalna, bez ręcznego kopiowania plików!**

---

## FAQ – patrz niżej (backup, troubleshooting, personalizacja)


