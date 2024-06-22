{ config, ... }:

{
  services.headscale = {
    enable = true;
    address = "0.0.0.0";
    port = 4000;
    settings = {
      server_url = "https://hs.dogbuilt.net";
      logtail.enabled = false;
      ip_prefixes = [ "fd7a:115c:a1e0::/48" "100.64.0.0/10" ];

      dns_config = {
        base_domain = "dogbuilt.net";
        extra_records = [
          {
            name = "rss.priv.dogbuilt.net";
            type = "A";
            value = "100.64.0.1";
          }
          {
            name = "search.priv.dogbuilt.net";
            type = "A";
            value = "100.64.0.1";
          }
          {
            name = "yacy.priv.dogbuilt.net";
            type = "A";
            value = "100.64.0.1";
          }
        ];
      };
    };
  };
  environment.systemPackages = [ config.services.headscale.package ];

  services.caddy.extraConfig = ''
    hs.dogbuilt.net {
      reverse_proxy * localhost:4000
    }
  '';
}
