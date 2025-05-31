# -----------------------------------------------------------------------------
# Plik: home/ravert/home.nix
# Home Manager - pełna konfiguracja środowiska użytkownika
# -----------------------------------------------------------------------------

{ config, pkgs, ... }:

{
  home.username = "ravert";
  home.homeDirectory = "/home/ravert";
  programs.zsh.enable = true;
  home.packages = with pkgs; [
    flameshot lxappearance copyq nitrogen feh i3lock-fancy xautolock blueman pavucontrol thunar firefox alacritty xclip dunst polybar picom rofi font-awesome jetbrains-mono papirus-icon-theme nordic dmz-cursor-theme
  ];
  gtk = {
    enable = true;
    theme = { name = "Nordic"; package = pkgs.nordic; };
    iconTheme = { name = "Papirus-Dark"; package = pkgs.papirus-icon-theme; };
    cursorTheme = { name = "DMZ-White"; package = pkgs.dmz-cursor-theme; };
  };
  fonts.fontconfig.enable = true;
  home.sessionVariables = { GDK_SCALE = "1"; GDK_DPI_SCALE = "1"; GTK_THEME = "Nordic"; };
  xsession.initExtra = ''feh --bg-scale ~/Pictures/Wallpapers/archcraft-nordic.jpg'';
  home.sessionPath = [
    "$HOME/.local/bin"
    "$HOME/.config/openbox"
    "$HOME/.config/polybar"
    "$HOME/.config/rofi"
    "$HOME/.config/picom"
    "$HOME/.config/dunst"
    "$HOME/.config/alacritty"
  ];
  programs.zsh.shellAliases = {
    ll = "ls -l";
    la = "ls -la";
    update = "nixos-rebuild switch --flake ~/nixos-t480-modular#t480";
    vault = "~/.local/bin/mount-vault.sh";
    pbcopy = "xclip -selection clipboard";
    pbpaste = "xclip -selection clipboard -o";
  };
  home.file = {
    ".config/openbox/rc.xml".source = ./config/openbox/rc.xml;
    ".config/openbox/menu.xml".source = ./config/openbox/menu.xml;
    ".config/openbox/autostart".source = ./config/openbox/autostart;
    ".config/polybar/config".source = ./config/polybar/config;
    ".config/picom.conf".source = ./config/picom.conf;
    ".config/rofi/config".source = ./config/rofi/config;
    ".config/dunst/dunstrc".source = ./config/dunst/dunstrc;
    ".config/alacritty/alacritty.yml".source = ./config/alacritty/alacritty.yml;
  };
  services.gammastep = {
    enable = true;
    latitude = "52.23";
    longitude = "21.01";
    tray = true;
    settings = {
      general = { adjustment-method = "randr"; gamma = "0.8"; };
      temp-day = 5500;
      temp-night = 3700;
    };
  };
  services.syncthing = {
    enable = true;
    openDefaultPorts = true;
    dataDir = "~/Sync";
    configDir = ".config/syncthing";
  };
  xdg.autostart.enable = true;
  xdg.configFile."autostart/blueman.desktop".source = pkgs.writeText "blueman.desktop" ''
    [Desktop Entry]
    Type=Application
    Name=Blueman Applet
    Exec=blueman-applet
    NoDisplay=false
    X-GNOME-Autostart-enabled=true
  '';
  xdg.configFile."autostart/pavucontrol.desktop".source = pkgs.writeText "pavucontrol.desktop" ''
    [Desktop Entry]
    Type=Application
    Name=PulseAudio Volume Control
    Exec=pavucontrol
    NoDisplay=false
    X-GNOME-Autostart-enabled=true
  '';
  programs.flatpak.enable = true;
  services.dunst.enable = true;
  home.stateVersion = "23.11";
}
