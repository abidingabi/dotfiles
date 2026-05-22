{ pkgs-unstable, ... }:

{
  home-manager.users.abi = {
    programs.kitty = {
      enable = true;

      extraConfig = ''
        font_family Fira Mono
        cursor_shape beam
        font_size 14
        shell ${pkgs-unstable.fish}/bin/fish
        confirm_os_window_close 0
        window_margin_width 6
      '';
    };
  };
}
