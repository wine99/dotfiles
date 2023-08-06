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
}
