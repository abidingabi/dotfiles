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

        # System Manager
        "gnome-system-monitor/solaris-mode" =
          false; # Do not divide CPU usage by CPU count
      };
    };
  };
}
