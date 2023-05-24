{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-22.11";

    home-manager.url = "github:nix-community/home-manager/release-22.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
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
        poppy = mkSystem "x86_64-linux" "22.11" "poppy"; # a graphical vm
      };
    };
}
