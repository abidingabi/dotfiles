{ pkgs, ... }:

{
  home-manager.users.abi = {
    programs.rofi = {
      enable = true;
      terminal = "${pkgs.kitty}/bin/kitty";
      cycle = false;
      theme = "sidebar";
      extraConfig = { width = 400; };
    };
  };
}
