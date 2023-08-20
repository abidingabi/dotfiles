{ config, lib, pkgs, ... }:

# tailscale needs to have --accept-dns=false set on the host
let ip = "100.64.0.1";
in {
  virtualisation.oci-containers.containers.pihole = {
    # 2023.05.2, linux/amd64
    image =
      "docker.io/pihole/pihole@sha256:06790d4a2409ef65bd2415e0422deb3a242119a43e33f4c9e8b97ca586017743";
    ports = [ "${ip}:53:53/tcp" "${ip}:53:53/udp" "127.0.0.1:4002:80" ];
    volumes = [ "etc-pihole:/etc/pihole/" "etc-dnsmasq.d:/etc/dnsmasq.d/" ];
    environment = {
      ServerIP = ip;
      WEBPASSWORD = "password";
    };
    extraOptions = [ "--dns=1.1.1.1" ];
  };

  services.headscale.settings.dns_config = {
    override_local_dns = true;
    nameservers = [ ip ];

    extra_records = [{
      name = "pihole.priv.dogbuilt.net";
      type = "A";
      value = ip;
    }];
  };

  services.caddy.extraConfig = ''
    http://pihole.priv.dogbuilt.net {
      rewrite / /admin
      reverse_proxy localhost:4002
    }
  '';
}
