{ config, lib, pkgs, ... }:

{
  hardware.bluetooth.enable = true;
  # services.blueman.enable = true;

  # auto mount usb drives
  # services.udiskie.enable = true;
}
