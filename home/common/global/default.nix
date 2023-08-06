{ config, pkgs, ... }:
{
  imports = [
    ./common.nix
    ./git.nix
    ./pl.nix
    ./emacs.nix
  ];
}
