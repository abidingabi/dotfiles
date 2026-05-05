{ lib, ... }: {

  services.displayManager.gdm.enable = true;
  services.desktopManager.gnome.enable = true;

  home-manager.users.abi = {
    dconf.enable = true;
    dconf.settings = {
      "org/gnome" = {
        # inputs
        "input-sources/sources" = [
          (lib.gvariant.mkTuple [ "xkb" "us+colemak" ])
          (lib.gvariant.mkTuple [ "xkb" "us" ])
        ];

        # UI things
        "desktop/interface/show-battery-percentage" = true;
        "desktop/interface/clock-format" = "12h";
        "settings/file-chooser/clock-format" = "12h";
        "desktop/interface/clock-show-weekday" = true;

        # Custom keybinds. Figure out how to make this nicer if you plan on
        # adding more (but probably just don’t add more).
        "settings-daemon/plugins/media-keys/custom-keybindings" = [
          "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/terminal/"
          "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/browser/"
          "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/editor/"
        ];

        "settings-daemon/plugins/media-keys/custom-keybindings/terminal/name" =
          "Terminal";
        "settings-daemon/plugins/media-keys/custom-keybindings/terminal/command" =
          "kitty";
        "settings-daemon/plugins/media-keys/custom-keybindings/terminal/binding" =
          "<Super>Return";

        "settings-daemon/plugins/media-keys/custom-keybindings/browser/name" =
          "Browser";
        "settings-daemon/plugins/media-keys/custom-keybindings/browser/command" =
          "firefox";
        "settings-daemon/plugins/media-keys/custom-keybindings/browser/binding" =
          "<Shift><Super>Return";

        "settings-daemon/plugins/media-keys/custom-keybindings/editor/name" =
          "Editor";
        "settings-daemon/plugins/media-keys/custom-keybindings/editor/command" =
          "emacsclient -c";
        "settings-daemon/plugins/media-keys/custom-keybindings/editor/binding" =
          "<Super>e";

        # Apps
        # System Manager
        "gnome-system-monitor/solaris-mode" =
          false; # Do not divide CPU usage by CPU count
      };
    };
  };
}
