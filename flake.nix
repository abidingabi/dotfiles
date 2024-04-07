{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.11";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager.url = "github:nix-community/home-manager/release-23.11";
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
          specialArgs = {
            inherit inputs;

            pkgs-unstable = import inputs.nixpkgs-unstable { system = system; };
          };
        };
    in {
      nixosConfigurations = {
        allium = mkSystem "x86_64-linux" "20.09" "allium"; # a laptop
        lily = mkSystem "x86_64-linux" "22.05" "lily"; # a vps
        orchid = mkSystem "x86_64-linux" "20.09" "orchid"; # a desktop
        poppy = mkSystem "x86_64-linux" "22.11" "poppy"; # a graphical vm
      };
    };
}
