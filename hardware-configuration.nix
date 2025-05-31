# -----------------------------------------------------------------------------
# Plik: hardware-configuration.nix
# GENEROWANY przez 'nixos-generate-config' - nie edytuj ręcznie, podmień na swój!
# Przykład poniżej:
# -----------------------------------------------------------------------------

{ config, lib, pkgs, modulesPath, ... }:

{
  imports = [ ];

  boot.initrd.availableKernelModules = [ "xhci_pci" "nvme" "thunderbolt" "usb_storage" "usbhid" "sd_mod" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" =
    { device = "/dev/disk/by-uuid/1111-2222-3333-4444";
      fsType = "btrfs";
      options = [ "subvol=root" ];
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/AAAA-BBBB";
      fsType = "vfat";
    };

  swapDevices = [
    { device = "/dev/disk/by-uuid/5555-6666"; }
  ];

  # Przykład montowania vaulta (nie auto-mount!)
  # fileSystems."/vault" = {
  #   device = "/dev/mapper/vault";
  #   fsType = "btrfs";
  #   options = [ "subvol=@vault" ];
  #   noCheck = true;
  #   neededForBoot = false;
  # };
}