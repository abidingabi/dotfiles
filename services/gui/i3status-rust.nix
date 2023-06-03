{ config, ... }:

{
  hmModules = [{
    programs.i3status-rust = {
      enable = true;
      bars.default = {
        theme = "gruvbox-dark";
        icons = "awesome4";

        blocks = let
          laptopBlocks = [
            {
              block = "battery";
              empty_threshold = 0;
              full_threshold = 100;
              interval = 10;
              device = "BAT0";
            }
            {
              block = "backlight";
              step_width = 5;
            }
          ];
        in (if config.dogbuilt.services.gui.laptopFeatures.enable then
          laptopBlocks
        else
          [ ]) ++ [
            {
              block = "sound";
              step_width = 5;
            }
            {
              block = "time";
              interval = 15;
              format = "$timestamp.datetime(f:'%a, %F %I:%M %p')";
            }
          ];
      };
    };
  }];
}
