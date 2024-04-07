{ pkgs-unstable, config, lib, ... }:

{
  services.tailscale = {
    enable = true;
    # unstable version of tailscale used to match tailscale-nginx-auth
    package = pkgs-unstable.tailscale;
  };

  # configure tailscale-nginx-auth, which is currently only in nixos-unstable
  systemd.packages = [ pkgs-unstable.tailscale-nginx-auth ];

  networking.firewall = {
    checkReversePath = "loose";
    trustedInterfaces = [ "tailscale0" ];
    allowedUDPPorts = [ config.services.tailscale.port ];
  };
}
