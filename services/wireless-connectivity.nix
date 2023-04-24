{ config, lib, pkgs, ... }:

{
  networking.networkmanager.enable = true;
  hardware.bluetooth.enable = true;
}
