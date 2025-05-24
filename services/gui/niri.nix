{ config, pkgs, inputs, ... }:

{
  imports = [ inputs.niri.nixosModules.niri ./fuzzel.nix ];
  programs.niri.enable = true;

  home-manager.users.abi = let osConfig = config;
  in { config, lib, ... }: {
    programs.niri.settings = {
      prefer-no-csd = true;
      spawn-at-startup =
        [{ command = [ (lib.getExe pkgs.xwayland-satellite) ]; }];

      environment = {
        DISPLAY = ":1"; # xwayland-satellite
      };

      input = {
        keyboard.xkb = {
          inherit (osConfig.services.xserver.xkb) layout variant options;
        };

        touchpad = {
          natural-scroll = false;
          scroll-factor = 1.0;
          # disable when typing
          dwt = true;
        };

        focus-follows-mouse.enable = true;
      };

      layout = {
        default-column-width.proportion = 1.0 / 2.0;
        preset-column-widths = [
          { proportion = 1.0 / 3.0; }
          { proportion = 1.0 / 2.0; }
          { proportion = 2.0 / 3.0; }
        ];

        gaps = 16;
      };

      binds = with config.lib.niri.actions; {
        # launch things
        "Mod+Return".action = spawn "kitty";
        "Mod+D".action = spawn "fuzzel";
        "Mod+Shift+Return".action = spawn "firefox";
        "Mod+E".action = spawn "emacsclient" "-c";
        "Mod+U".action = spawn "/etc/nixos/services/gui/symbols.sh";
        "Mod+Shift+V".action = spawn "copyq" "show";

        # move focus
        "Mod+Left".action = focus-column-left;
        "Mod+Down".action = focus-window-or-workspace-down;
        "Mod+Up".action = focus-window-or-workspace-up;
        "Mod+Right".action = focus-column-right;

        # move things
        "Mod+Shift+Left".action = move-column-left;
        "Mod+Shift+Down".action = move-window-down-or-to-workspace-down;
        "Mod+Shift+Up".action = move-window-up-or-to-workspace-up;
        "Mod+Shift+Right".action = move-column-right;

        # resize things

        # quit things
        "Mod+Shift+E".action = quit { skip-confirmation = false; };
        "Mod+Shift+Q".action = close-window;
      };
    };
  };
}
