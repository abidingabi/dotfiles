{
  home-manager.users.abi = {
    services.dunst.enable = true;
    services.dunst.settings = {
      global = {
        transparency = 10;
        geometry = "700-30+20";
      };

      ignored = {
        desktop_entry = "org.gnome.Lollypop";
        skip_display = true;
      };
    };
  };
}
