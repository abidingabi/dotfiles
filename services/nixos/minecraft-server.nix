{ ... }:

{
  services.minecraft-server = {
    enable = true;
    eula = true;
    declarative = true;
    serverProperties = {
      gamemode = "survival";
      difficulty = "normal";
      motd = "hiiiiiiiiii :3";
      "view-distance" = 22;
    };
    jvmOpts = "-Xms512M -Xmx1024M";
  };
}
