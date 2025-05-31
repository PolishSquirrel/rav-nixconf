# -----------------------------------------------------------------------------
# Plik: modules/optimize-thinkpad.nix
# Optymalizacje dla ThinkPad T480: power, TLP, thinkfan, Thunderbolt, fprintd, HiDPI
# -----------------------------------------------------------------------------

{ config, pkgs, ... }:

{
  # Mikrokod (zalecane)
  hardware.cpu.intel.updateMicrocode = true;

  # TLP - zarządzanie zasilaniem laptopa
  services.tlp.enable = true;

  # Thinkfan - zarządzanie wentylatorem
  services.thinkfan.enable = true;
  services.thinkfan.extraConfig = ''
    tp_fan /proc/acpi/ibm/fan
    sensor /sys/class/hwmon/hwmon0/temp1_input
    (0, 0, 55)
    (1, 48, 60)
    (2, 58, 65)
    (3, 63, 70)
    (7, 68, 32767)
  '';

  # tpacpi-bat - kontrola ładowania baterii
  services.tpacpi-bat.enable = true;

  # Fprintd - czytnik linii papilarnych
  services.fprintd.enable = true;

  # Thunderbolt - hotplug, zgodnie z https://nixos.wiki/wiki/Thunderbolt
  services.hardware.bolt.enable = true;

  # Jasność ekranu i HiDPI
  services.xserver.videoDrivers = [ "modesetting" ];
  hardware.opengl.enable = true;
  hardware.opengl.driSupport = true;
  hardware.opengl.driSupport32Bit = true;
}