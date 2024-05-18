{
  services.xserver.desktopManager.gnome.enable = true;
  # services.gnome.core-utilities.enable = false;
  home-manager.users.abi = {
    dconf = {
      enable = true;
      settings = {
        "org/gnome/desktop/peripherals/touchpad" = {
          "natural-scroll" = false;
          "tap-to-click" = true;
        };

        "org/gnome/settings-daemon/plugins/media-keys" = {
          "volume-up" = [ "AudioRaiseVolume" ];
          "volume-down" = [ "AudioLowerVolume" ];
          "volume-mute" = [ "AudioMute" ];
          "pause" = [ "AudioPlay" ];
          "previous" = [ "AudioPrev" ];
          "next" = [ "AudioNext" ];
        };

        "org/gnome/desktop/wm/keybindings" = {
          "switch-to-workspace-last" = [];
          "move-to-workspace-last" = [];

          "switch-to-workspace-1" = [ "<Super>1" ];
          "switch-to-workspace-2" = [ "<Super>2" ];
          "switch-to-workspace-3" = [ "<Super>3" ];
          "switch-to-workspace-4" = [ "<Super>4" ];
          "switch-to-workspace-5" = [ "<Super>5" ];
          "switch-to-workspace-6" = [ "<Super>6" ];
          "switch-to-workspace-7" = [ "<Super>7" ];
          "switch-to-workspace-8" = [ "<Super>8" ];
          "switch-to-workspace-9" = [ "<Super>9" ];
          "switch-to-workspace-10" = [ "<Super>0" ];

          "move-to-workspace-1" = [ "<Shift><Super>1" ];
          "move-to-workspace-2" = [ "<Shift><Super>2" ];
          "move-to-workspace-3" = [ "<Shift><Super>3" ];
          "move-to-workspace-4" = [ "<Shift><Super>4" ];
          "move-to-workspace-5" = [ "<Shift><Super>5" ];
          "move-to-workspace-6" = [ "<Shift><Super>6" ];
          "move-to-workspace-7" = [ "<Shift><Super>7" ];
          "move-to-workspace-8" = [ "<Shift><Super>8" ];
          "move-to-workspace-9" = [ "<Shift><Super>9" ];
          "move-to-workspace-10" = [ "<Shift><Super>0" ];
        };

        # need to be set for the above to work properly
        # see https://unix.stackexchange.com/a/510376
        "org/gnome/shell/keybindings" = {
          "switch-to-application-1" = [];
          "switch-to-application-2" = [];
          "switch-to-application-3" = [];
          "switch-to-application-4" = [];
          "switch-to-application-5" = [];
          "switch-to-application-6" = [];
          "switch-to-application-7" = [];
          "switch-to-application-8" = [];
          "switch-to-application-9" = [];
          "switch-to-application-10" = [];
        };

        "org/gnome/desktop/wm/preferences" = {
          "num-workspaces" = 10;
        };

        "org/gnome/mutter" = {
          "edge-tiling" = true;
          "dynamic-workspaces" = false;
        };

        "org/gnome/shell/app-switcher" = {
          "current-workspace-only" = true;
        };

        "org/gnome/desktop/interface" = {
          "show-battery-percentage" = true;
        };

        # "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" =
        #   {
        #     name = "foo";
        #     command = "kitty";
        #     binding = "<Alt>Return";
        #   };
      };
    };
  };
}
