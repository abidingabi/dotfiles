{ config, ... }:

{
  services.miniflux = {
    enable = true;

    adminCredentialsFile = "/etc/secrets/miniflux-admin-credentials";

    config = {
      BASE_URL = "http://rss.priv.dogbuilt.net/";
      LISTEN_ADDR = "127.0.0.1:4001";
    };
  };

  # see https://caddyserver.com/docs/caddyfile/directives/forward_auth#tailscale
  services.caddy.extraConfig = ''
    http://rss.priv.dogbuilt.net {
      encode zstd gzip
      reverse_proxy localhost:4001
    }
  '';
}
