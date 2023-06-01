{ specialArgs, ... }:

let
  port = 3000;
  hostname = "signalflags.dogbuilt.net";
in {
  imports = [ specialArgs.inputs.signal-flags.nixosModules.default ];

  dogbuilt.services.signal-flags = {
    enable = true;
    inherit port;
    url = "https://${hostname}/";
  };

  services.caddy.extraConfig = ''
    ${hostname} {
      encode zstd gzip
      reverse_proxy localhost:${toString port}
    }
  '';
}
