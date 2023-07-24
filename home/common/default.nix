{ config, pkgs, ... }:
{
  imports = [
    ./common.nix
    ./pl.nix
    ./media.nix
  ];
}
