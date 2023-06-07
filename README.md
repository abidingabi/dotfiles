# Local Install
First, format the drive appropriately (follow the NixOS manual). Then, mount it and clone this repository:

```sh
git clone https://github.com/abidingabi/dotfiles /mnt/etc/nixos
```

Then, add the device to `flake.nix`, and create its configuration at `devices/hostname.nix`.

Finally, install NixOS:

```sh
nix-shell -p nixUnstable 
nixos-install --flake /mnt/etc/nixos#hostname
```

# Deploying to headless systems
To deploy to headless systems, run:

```sh
./deploy-to-headless-systems.sh
```

This requires ssh access to root on the headless systems, and assumes that both the local and remote systems are running NixOS.
