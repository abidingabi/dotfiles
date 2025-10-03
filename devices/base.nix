{ config, lib, pkgs, inputs, ... }:

let username = "abi";
in {
  # Set up home manager
  imports = [
    inputs.lix-module.nixosModules.default
    inputs.home-manager.nixosModules.home-manager
    {
      home-manager.useGlobalPkgs = true;
      home-manager.useUserPackages = true;
    }
  ];

  config = {
    nix = {
      settings = {
        auto-optimise-store = true;
        experimental-features = [ "nix-command" "flakes" ];
      };

      channel.enable = false;
    };

    nixpkgs.config.allowUnfree = true;

    programs.nix-ld.enable = true;

    # Basic useful packages
    environment.systemPackages = with pkgs; [ git vim wget ];

    time.timeZone = "America/New_York";

    users.users.${username} = {
      isNormalUser = true;
      extraGroups = [ "wheel" ]; # Enables sudo
    };

    # add a symlink to bash at /bin/bash for compatibility
    systemd.tmpfiles.settings."compatibility"."/bin/bash"."L" = {
      argument = "${pkgs.bash}/bin/bash";
    };
  };
}
