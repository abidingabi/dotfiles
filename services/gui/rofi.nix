{ pkgs, ... }:

{
  hmModules = [{
    programs.rofi = {
      enable = true;
      terminal = "${pkgs.kitty}/bin/kitty";
      cycle = false;
      theme = "sidebar";
      extraConfig = { width = 400; };
    };
  }];
}
