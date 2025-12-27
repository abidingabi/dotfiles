{ pkgs, ... }:

{
  services.minecraft-server = {
    enable = true;
    eula = true;
    declarative = true;
    # set version to 1.21.11, taken from
    # https://github.com/NixOS/nixpkgs/pull/469498/
    package = pkgs.minecraft-server.override {
      url =
        "https://piston-data.mojang.com/v1/objects/64bb6d763bed0a9f1d632ec347938594144943ed/server.jar";
      version = "1.21.11";
      sha1 = "64bb6d763bed0a9f1d632ec347938594144943ed";
    };
    serverProperties = {
      gamemode = "survival";
      difficulty = "normal";
      motd = "hiiiiiiiiii :3";
    };
    jvmOpts = "-Xms512M -Xmx1024M";
  };
}
