#!/usr/bin/env bash
echo "lily:"
nixos-rebuild switch \
  --target-host root@5.161.71.187 \
  --flake $(dirname "${BASH_SOURCE[0]}")#lily
