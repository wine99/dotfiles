{ config, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    wineWowPackages.stable
    winetricks
  ];
}
