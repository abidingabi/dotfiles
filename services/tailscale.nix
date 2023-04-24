{ config, lib, pkgs, ... }:

{
  options.dogbuilt.services.tailscale = {
    exitNodeSupport.enable =
      lib.mkEnableOption "kernel options needed to act as an exit node";
  };

  config = let cfg = config.dogbuilt.services.tailscale;
  in {
    services.tailscale.enable = true;
    networking.firewall = {
      checkReversePath = "loose";
      trustedInterfaces = [ "tailscale0" ];
      allowedUDPPorts = [ config.services.tailscale.port ];
    };

    # See https://tailscale.com/kb/1103/exit-nodes/?tab=linux#step-1-advertise-a-device-as-an-exit-node
    boot.kernel.sysctl = lib.mkIf cfg.exitNodeSupport.enable {
      "net.ipv4.ip_forward" = 1;
      "net.ipv6.conf.all.forwarding" = 1;
    };
  };
}
