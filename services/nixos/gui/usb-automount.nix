{ pkgs, ... }:

{
  # automount disks
  services.udisks2.enable = true;
  home-manager.users.abi = {
    services.udiskie.enable = true;
  };
}
