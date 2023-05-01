{ config, lib, pkgs, ... }:

{
  options.dogbuilt.services.gui = {
    laptopFeatures.enable = lib.mkEnableOption "laptop features";
  };

  config = let barName = "default";
  in {
    services.xserver.enable = true;
    services.xserver.displayManager.sddm.enable = true;
    services.xserver.libinput.enable = true;
    services.xserver.libinput.mouse.accelProfile = "flat";

    # keyboard options (redefined for sway in sway configuration)
    services.xserver.layout = "us,us";
    services.xserver.xkbVariant = "colemak,";
    services.xserver.xkbOptions = "grp:rctrl_toggle";

    # map CapsLock to Esc on single press and Ctrl on when used with multiple keys.
    services.interception-tools = {
      enable = true;
      plugins = [ pkgs.interception-tools-plugins.caps2esc ];
      udevmonConfig = ''
        - JOB: "${pkgs.interception-tools}/bin/intercept -g $DEVNODE | ${pkgs.interception-tools-plugins.caps2esc}/bin/caps2esc | ${pkgs.interception-tools}/bin/uinput -d $DEVNODE"
          DEVICE:
            EVENTS:
              EV_KEY: [KEY_CAPSLOCK, KEY_ESC]
      '';
    };

    # sound configuration
    sound.enable = false;
    security.rtkit.enable = true;
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };

    security.polkit.enable = true; # necessary for sway to start
    programs.sway.enable = true;

    hmModules = [
      # packages relevant to sway
      {
        home.packages = with pkgs; [
          xdg-utils # for opening default programs when clicking links
          glib # gsettings
          gnome3.adwaita-icon-theme # default gnome cursors
          xdg-desktop-portal
          xdg-desktop-portal-wlr
          grim # needed for flameshot

          flameshot
          copyq
          wl-clipboard # wl-copy and wl-paste for copy/paste from stdin / stdout

          # fonts
          fira-mono
          overpass
          noto-fonts
          noto-fonts-cjk
          noto-fonts-extra
          noto-fonts-emoji
          noto-fonts-emoji-blob-bin
          emacs-all-the-icons-fonts # used for emacs and i3status-rust
        ];

        fonts.fontconfig.enable = true;
      }

      # sway configuration
      ({ config, lib, ... }: {
        wayland.windowManager.sway = {
          enable = true;
          config = {
            startup = [
              {
                command =
                  "dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP=sway && systemctl --user stop pipewire pipewire-media-session xdg-desktop-portal xdg-desktop-portal-wlr && systemctl --user start pipewire pipewire-media-session xdg-desktop-portal xdg-desktop-portal-wlr";
              }
              {
                command = let
                  schema = pkgs.gsettings-desktop-schemas;
                  datadir = "${schema}/share/gsettings-schemas/${schema.name}";
                in "export XDG_DATA_DIRS=${datadir}:$XDG_DATA_DIRS && gnome_schema=org.gnome.desktop.interface && gsettings set $gnome_schema gtk-theme 'Adwaita'";
              }

              { command = "copyq show"; }
            ];

            modifier = "Mod4";
            terminal = "${pkgs.kitty}/bin/kitty";

            input."*" = {
              xkb_layout = "us,us";
              xkb_variant = "colemak,";
              xkb_options = "grp:rctrl_toggle";

              accel_profile = "flat";
            };

            output."*" = {
              background = "${./xenia-outline.png} center #606060";
            };

            keybindings =
              let modifier = config.wayland.windowManager.sway.config.modifier;
              in lib.mkOptionDefault {
                "${modifier}+Shift+Return" = "exec firefox";
                "${modifier}+Shift+s" = "exec flameshot gui";
                "${modifier}+Shift+v" = "exec copyq show";
                "${modifier}+d" = "exec rofi -modi drun -show drun";
                "${modifier}+e" = "exec emacsclient -c";
              };

            fonts = {
              names = [ "Fira Mono" ];
              size = 10.0;
            };

            bars = [{
              fonts = {
                names = [ "Fira Mono" ];
                size = 10.0;
              };

              statusCommand =
                "${pkgs.i3status-rust}/bin/i3status-rs ~/.config/i3status-rust/config-${barName}.toml";
            }];

            window.commands = [{
              command = "floating enable";
              criteria = { class = "copyq"; };
            }];
          };
        };
      })

      # sway helper program configuration
      {
        programs.i3status-rust = {
          enable = true;
          bars.${barName} = {
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
      }

      {
        programs.rofi = {
          enable = true;
          package = pkgs.rofi-wayland;
          terminal = "${pkgs.kitty}/bin/kitty";
          cycle = false;
          theme = "sidebar";
          extraConfig = { width = 400; };
        };
      }

      {
        services.dunst.enable = true;
        services.dunst.settings = {
          global = {
            transparency = 10;
            geometry = "700-30+20";
          };
        };
      }
    ];
  };
}
