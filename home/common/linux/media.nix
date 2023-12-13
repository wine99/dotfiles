{ pkgs, config, inputs, ... }:
let
  spicePkgs = inputs.spicetify-nix.packages.${pkgs.system}.default;
in
{
  imports = [
    inputs.spicetify-nix.homeManagerModule
  ];

  home.packages = with pkgs; [
    ffmpeg
    flac
    libva
    libva-utils

    vlc
    imv

    # spotify
    spotify-tray
    # yesplaymusic
  ];

  programs = {
    mpv = {
      enable = false;
      defaultProfiles = [ "gpu-hq" ];
      scripts = [ pkgs.mpvScripts.mpris ];
    };

    obs-studio.enable = true;
  };

  programs.spicetify = {
    enable = true;
    # theme = spicePkgs.themes.official.Default;
    colorScheme = "nord-light";

    enabledCustomApps = with spicePkgs.apps; [
      new-releases
      lyrics-plus
      localFiles
      marketplace
    ];

    enabledExtensions = with spicePkgs.extensions; [
      # "playlistIcons.js" # only needed if not using dribbblish
      fullAlbumDate
      fullAppDisplay
      shuffle # shuffle+ (special characters are sanitized out of ext names)
      showQueueDuration
      playNext
    ];
  };

  # services = {
  #   playerctld.enable = true;
  # };
}
