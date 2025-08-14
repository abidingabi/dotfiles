{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";

    lix-module = {
      url =
        "https://git.lix.systems/lix-project/nixos-module/archive/2.93.2-1.tar.gz";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager.url = "github:nix-community/home-manager/release-25.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    signal-flags.url = "github:abidingabi/signal-flags";
    signal-flags.inputs.nixpkgs.follows = "nixpkgs";

    pronounspace = {
      type = "github";
      owner = "abidingabi";
      repo = "pronounspace";
      flake = false;
    };
  };

  outputs = inputs:
    let
      mkSystem = system: stateVersion: hostName:
        inputs.nixpkgs.lib.nixosSystem {
          modules = [
            ./devices/base.nix
            ./devices/${hostName}.nix
            {
              nixpkgs.hostPlatform = system;
              networking.hostName = hostName;
              system.stateVersion = stateVersion;
              home-manager.users.abi = { home.stateVersion = stateVersion; };
            }
          ];
          specialArgs = {
            inherit inputs;

            pkgs-unstable = inputs.nixpkgs-unstable.legacyPackages.${system};
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
