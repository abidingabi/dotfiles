#!/usr/bin/env sh
echo "lily:"
nixos-rebuild switch --no-build-nix --target-host root@5.161.71.187 --flake .#lily
