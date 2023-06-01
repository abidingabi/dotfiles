{  ... }:

{
  services.miniflux = {
    enable = true;

    adminCredentialsFile = "/etc/secrets/miniflux-admin-credentials";

    config = {
      BASE_URL = "https://rss.priv.dogbuilt.net/";
      CREATE_ADMIN = "1";
      LISTEN_ADDR = "127.0.0.1:4001";
    };
  };

  services.caddy.extraConfig = ''
    http://rss.priv.dogbuilt.net rss.priv.dogbuilt.net {
      tls internal
      encode zstd gzip
      reverse_proxy localhost:4001
    }
  '';
}
