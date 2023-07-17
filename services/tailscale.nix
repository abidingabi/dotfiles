{ pkgs, config, lib, ... }:

{
  options.dogbuilt.services.tailscale = {
    exitNodeSupport.enable =
      lib.mkEnableOption "kernel options needed to act as an exit node";
  };

  config = let cfg = config.dogbuilt.services.tailscale;
  in {
    services.tailscale = {
      enable = true;

      # Builds support for nginx-auth, see https://github.com/NixOS/nixpkgs/issues/227380.
      package = pkgs.tailscale.override {
        buildGoModule = args:
          pkgs.buildGoModule (args // {
            subPackages = args.subPackages ++ [ "cmd/nginx-auth" ];
            postInstall = args.postInstall + ''
              sed -i -e "s#/usr/sbin/tailscale.#$out/bin/#" ./cmd/nginx-auth/tailscale.nginx-auth.service
              install -D -m0444 -t $out/lib/systemd/system ./cmd/nginx-auth/tailscale.nginx-auth.service
              sed -i -e "s#/var/run#/run#" ./cmd/nginx-auth/tailscale.nginx-auth.socket
              sed -i -e "/^Wants/d" ./cmd/nginx-auth/tailscale.nginx-auth.service
              sed -i -e "/^After/d" ./cmd/nginx-auth/tailscale.nginx-auth.service
              install -D -m0444 -t $out/lib/systemd/system ./cmd/nginx-auth/tailscale.nginx-auth.socket
            '';
          });
      };
    };
    systemd.sockets."tailscale.nginx-auth".wantedBy = [ "multi-user.target" ];
    systemd.services."tailscale.nginx-auth".after = [ ];
    systemd.services."tailscale.nginx-auth".wants = [ ];

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
