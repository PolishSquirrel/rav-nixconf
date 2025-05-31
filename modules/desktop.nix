# -----------------------------------------------------------------------------
# Plik: modules/desktop.nix
# Konfiguracja środowiska desktopowego: Openbox, Polybar, Rofi, Picom, Dunst, Home Manager
# -----------------------------------------------------------------------------

{ config, pkgs, ... }:

{
  # Instalacja środowiska X11 oraz Openbox
  services.xserver.enable = true;
  services.xserver.layout = "pl";
  services.xserver.xkbVariant = "";
  services.xserver.displayManager.startx.enable = true; # startx zamiast DM
  services.xserver.windowManager.openbox.enable = true;

  # Dodatkowe pakiety graficzne
  environment.systemPackages = with pkgs; [
    alacritty
    openbox
    polybar
    picom
    rofi
    dunst
    nitrogen
    lxappearance
    feh
    flameshot
    pavucontrol
    blueman
    thunar
    xclip
    copyq
  ];

  # Dźwięk
  sound.enable = true;
  hardware.pulseaudio.enable = true;

  # Instalacja fontów i motywów globalnie
  fonts.packages = with pkgs; [
    jetbrains-mono
    font-awesome
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
    papirus-icon-theme
    nordic
    dmz-cursor-theme
  ];

  # Home Manager włączony w flake.nix
}