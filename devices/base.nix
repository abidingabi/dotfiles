{ config, lib, pkgs, inputs, ... }:

let username = "abi";
in {
  # Set up home manager
  imports = [
    inputs.home-manager.nixosModules.home-manager
    {
      home-manager.useGlobalPkgs = true;
      home-manager.useUserPackages = true;
    }
  ];

  config = {
    nix = {
      # Enables e.g. nix shell to run faster by using system's nixpkgs registry
      # instead of downloading it every time
      registry.nixpkgs.flake = inputs.nixpkgs;

      settings = {
        auto-optimise-store = true;
        experimental-features = [ "nix-command" "flakes" ];
      };
    };

    nixpkgs.config.allowUnfree = true;

    # Basic useful packages
    environment.systemPackages = with pkgs; [ git vim wget ];

    time.timeZone = "America/New_York";

    users.users.${username} = {
      isNormalUser = true;
      extraGroups = [ "wheel" ]; # Enables sudo
    };
  };
}
