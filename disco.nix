{
  disko.devices.disk.main = {
    type = "disk";
    device = "/dev/nvme0n1";

    content = {
      type = "gpt";

      partitions = {
        ESP = {
          priority = 1;  # Tworzona jako pierwsza
          name = "ESP";
          start = "1MiB";
          end = "1025MiB";  # 1 GiB na EFI /boot
          type = "EF00";
          content = {
            type = "filesystem";
            format = "vfat";
            mountpoint = "/boot";
            mountOptions = [ "umask=0077" ];
          };
        };

        vault = {
          priority = 2;  # Tworzona jako druga
          size = "20G";
          name = "vault";
          type = "8309";  # Poprawny typ dla LUKS
          content = {
            type = "luks";
            name = "vault_luks";
            content = {
              type = "filesystem";
              format = "btrfs";
              mountOptions = [ "compress=zstd" ];  # Ręczne montowanie z pulpitu
            };
          };
        };

        swap = {
          priority = 3;  # Tworzona przed root
          size = "34G";  # Dla hibernacji, wspiera do 32 GB RAM
          name = "swap";
          type = "8200";  # Typ dla partycji swap
          content = {
            type = "swap";
            resumeDevice = true;  # Wskazuje, że to partycja dla hibernacji
          };
        };

        root = {
          priority = 4;  # Tworzona jako ostatnia
          size = "100%";  # Używa reszty miejsca
          content = {
            type = "btrfs";
            extraArgs = [ "-f" ];
            subvolumes = {
              "@root" = {
                mountpoint = "/";
                mountOptions = [ "noatime" ];
              };
              "@home" = {
                mountpoint = "/home";
                mountOptions = [ "compress=zstd" ];
              };
              "@nix" = {
                mountpoint = "/nix";
                mountOptions = [ "compress=zstd" "noatime" ];
              };
              "@persist" = {
                mountpoint = "/persist";
                mountOptions = [ "noatime" ];
              };
              "@snapshots" = {
                mountpoint = "/.snapshots";
                mountOptions = [ "noatime" ];
              };
            };
          };
        };
      };
    };
  };
}
