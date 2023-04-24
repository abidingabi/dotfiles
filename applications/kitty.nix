{ config, lib, pkgs, ... }:

{
  hmModules = [{
    programs.kitty = {
      enable = true;

      extraConfig = ''
        font_family Fira Mono
        cursor_shape beam
        font_size 14
        shell fish
        confirm_os_window_close 0
      '';
    };
  }];
}
