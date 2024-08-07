{ inputs, ... }:

{
  services.caddy.extraConfig = ''
    pronounspace.dogbuilt.net {
      redir https://pronouns.dogbuilt.net{uri} permanent
    }

    pronouns.dogbuilt.net {
      encode zstd gzip
      root * ${inputs.pronounspace}
      file_server
    }
  '';
}
