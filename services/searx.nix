{
  services.searx = {
    enable = true;
    settings = {
      server = {
        base_url = "http://search.priv.dogbuilt.net";
        bind_address = "127.0.0.1";
        port = 4002;
        # nobody can access this instance
        secret_key = "foobar";
      };
    };
  };

  services.caddy.extraConfig = ''
    http://search.priv.dogbuilt.net {
      reverse_proxy localhost:4002
    }
  '';
}
