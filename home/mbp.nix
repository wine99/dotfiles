{ inputs, outputs, lib, config, pkgs, username, ... }: {
  imports = [
    ./common/global
  ];

  nixpkgs = {
    config = {
      allowUnfree = true;
      allowUnfreePredicate = (_: true);
    };
  };

  home = {
    inherit username;
    homeDirectory = "/Users/${username}";
    stateVersion = "23.05";
  };

  home.packages = with pkgs; [
    spicetify-cli
  ];

  programs.home-manager.enable = true;

  # https://discourse.nixos.org/t/brew-not-on-path-on-m1-mac/26770
  programs.fish.loginShellInit = ''
    eval $(/opt/homebrew/bin/brew shellenv)
  '';
}
