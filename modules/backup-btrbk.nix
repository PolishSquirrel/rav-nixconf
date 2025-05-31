# -----------------------------------------------------------------------------
# Plik: modules/backup-btrbk.nix
# Tygodniowy backup Btrfs vaulta z usuwaniem snapshotów starszych niż 45 dni
# -----------------------------------------------------------------------------

{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [ btrbk ];

  services.btrbk = {
    enable = true;
    config = ''
      timestamp_format long
      snapshot_preserve_min 7d
      snapshot_preserve 45d
      volume /vault
        snapshot_dir snapshots
        target /vault/backups
        subvolume data
        snapshot_create weekly
        snapshot_preserve_min 7d
        snapshot_preserve 45d
    '';
  };

  systemd.timers."btrbk-prune" = {
    wantedBy = [ "timers.target" ];
    timerConfig.OnCalendar = "weekly";
    timerConfig.Persistent = "true";
  };

  systemd.services."btrbk-prune" = {
    script = ''
      find /vault/backups/ -maxdepth 1 -type d -mtime +45 -exec rm -rf {} +
    '';
    serviceConfig = {
      Type = "oneshot";
      User = "root";
    };
  };
}