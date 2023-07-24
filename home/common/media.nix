{ pkgs, config, ... }:
# media - control and enjoy audio/video
{
  # imports = [
  # ];

  home.packages = with pkgs; [
    ffmpeg
    flac
    libva
    libva-utils

    gimp
    viu
    imv
    # playerctl

    spotify
    spicetify-cli
    yesplaymusic
  ];

  programs = {
    mpv = {
      enable = false;
      defaultProfiles = ["gpu-hq"];
      scripts = [pkgs.mpvScripts.mpris];
    };

    obs-studio.enable = true;
  };

  # services = {
  #   playerctld.enable = true;
  # };
}
