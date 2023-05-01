{ config, ... }:

{
  hmModules = [{
    programs.i3status-rust = {
      enable = true;
      bars.default = {
        theme = "gruvbox-dark";
        icons = "awesome";

        blocks = let
          laptopBlocks = [
            {
              block = "battery";
              interval = 10;
              format = "{percentage}";
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
              format = "%a, %F %I:%M %p";
            }
          ];
      };
    };
  }];
}
