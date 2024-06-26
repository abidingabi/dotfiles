{ config, ... }:

{
  services.miniflux = {
    enable = true;

    adminCredentialsFile = "/etc/secrets/miniflux-admin-credentials";

    config = {
      BASE_URL = "http://rss.priv.dogbuilt.net/";
      LISTEN_ADDR = "127.0.0.1:4001";

      AUTH_PROXY_HEADER = "X-Webauth-User";
    };
  };

  services.tailscaleAuth = {
    enable = true;
    user = config.services.caddy.user;
    group = config.services.caddy.group;
  };

  # see https://caddyserver.com/docs/caddyfile/directives/forward_auth#tailscale
  services.caddy.extraConfig = ''
    http://rss.priv.dogbuilt.net {
      forward_auth unix//run/tailscale-nginx-auth/tailscale-nginx-auth.sock {
        uri /auth
        header_up Remote-Addr {remote_host}
        header_up Remote-Port {remote_port}
        header_up Original-URI {uri}
        copy_headers {
          Tailscale-User>X-Webauth-User
        }
      }

      encode zstd gzip
      reverse_proxy localhost:4001
    }
  '';
}
