{ config, lib, pkgs, ... }:

{
  hmModules = [{
    services.redshift = {
      enable = true;
      tray = true;
      dawnTime = "6:00-8:00";
      duskTime = "18:00-20:00";
      temperature = {
        day = 4500;
        night = 3700;
      };
    };
  }];
}
