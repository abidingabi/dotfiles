{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.05";

    home-manager.url = "github:nix-community/home-manager/release-23.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    signal-flags.url = "github:abidingabi/signal-flags";
    signal-flags.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs:
    let
      mkSystem = system: stateVersion: hostName:
        inputs.nixpkgs.lib.nixosSystem {
          inherit system;
          modules = [
            ./devices/base.nix
            ./devices/${hostName}.nix
            {
              networking.hostName = hostName;
              system.stateVersion = stateVersion;
              hmModules = [{ home.stateVersion = stateVersion; }];
            }
          ];
          specialArgs = { inherit inputs; };
        };
    in {
      nixosConfigurations = {
        allium = mkSystem "x86_64-linux" "20.09" "allium"; # a laptop
        lily = mkSystem "x86_64-linux" "22.05" "lily"; # a vps
        poppy = mkSystem "x86_64-linux" "22.11" "poppy"; # a graphical vm
      };
    };
}
