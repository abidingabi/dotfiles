{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";

    # Use `github:nix-darwin/nix-darwin/nix-darwin-25.11` to use Nixpkgs 25.11.
    nix-darwin.url = "github:nix-darwin/nix-darwin/nix-darwin-25.11";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";

    home-manager.url = "github:nix-community/home-manager/release-25.11";
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
        poppy = mkSystem "x86_64-linux" "22.11" "poppy"; # a graphical vm
      };

      darwinConfigurations."magnolia" = inputs.nix-darwin.lib.darwinSystem {
        modules = [
          ./devices/magnolia.nix

          inputs.home-manager.darwinModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
          }
        ];
        specialArgs = {
          inherit inputs;

          # this is a hack
          pkgs-unstable =
            inputs.nixpkgs-unstable.legacyPackages."aarch64-darwin";
        };
      };

    };
}
