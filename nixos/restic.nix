{ config, pkgs, ... }:

{
  environment.systemPackages = [ pkgs.restic ];

  services.restic.backups.abidingabi = {
    initialize = true;

    timerConfig = {
      OnCalendar = "23:00";
      WakeSystem = true;
    };

    paths = [ "/home/abi" ];
    extraBackupArgs =
      [ "--exclude=/home/abi/.cache/*" "--exclude=/home/abi/Android/*" ];

    pruneOpts = [ "--keep-daily 7" "--keep-weekly 4" "--keep-yearly 10" ];

    repository = "s3:s3.us-east-005.backblazeb2.com/abidingabi-restic-backup";
    environmentFile = "/home/abi/.local/share/restic/b2-credentials";
    passwordFile = "/home/abi/.local/share/restic/password";
  };

  systemd.services.restic-backups-abidingabi = {
    wants = [ "network-online.target" ];
    after = [ "network-online.target" ];
  };
}
