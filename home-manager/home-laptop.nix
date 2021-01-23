{ pkgs, ... }:

{
  imports = [ ./common.nix ];

  xdg = {
    enable = true;

    configFile = {
      "doom" = {
        source = ../doom;
        recursive = true;
      };

      "i3/config".source = ../i3/config;

      "i3status-rust/status.toml".source = ../i3status-rust/status-laptop.toml;

      "git" = {
        source = ../git;
        recursive = true;
      };

      "fish" = {
        source = ../fish;
        recursive = true;
      };

      "nixpkgs/config.nix".text = "{ allowUnfree = true; }";
    };
  };
}
