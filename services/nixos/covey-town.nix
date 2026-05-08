{ config, lib, pkgs, ... }:

{
  users.users.covey = { isNormalUser = true; };

  users.users.covey.openssh.authorizedKeys.keys =
    config.users.users.abi.openssh.authorizedKeys.keys ++ [''
      ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJvyaS30T+U6uf6oQabxGqOgtecOWsxc9tTsPjU2eJ5t github actions
    ''];

  virtualisation = { podman.enable = true; };

  services.caddy.extraConfig = ''
    covey.dogbuilt.net {
      reverse_proxy * localhost:8080
    }

    coveytownservice.dogbuilt.net {
      reverse_proxy * localhost:8081
    }
  '';
}
