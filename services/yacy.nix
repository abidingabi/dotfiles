{
  virtualisation.oci-containers.containers.yacy = {
    # 1.93, linux/amd64
    image =
      "docker.io/yacy/yacy_search_server@sha256:4b6b0c69503bd30abe51d2532ef2c3c06a220efbb1fa175afb6982d68cc54ade";
    ports = [ "4003:8090" ];
    volumes = [ "yacy_search_server_data:/var/yacy/" ];
  };

  services.caddy.extraConfig = ''
    http://yacy.priv.dogbuilt.net {
      reverse_proxy localhost:4003
    }
  '';
}
