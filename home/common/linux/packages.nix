{ pkgs, ... }: {
  home.packages = with pkgs; [
    gnumake
    gcc
    # clang-tools
    # clang-analyzer
    # lldb

    # nvtop
    google-chrome
    # firefox

    zotero

    jetbrains.pycharm-professional
    jetbrains.idea-ultimate

    telegram-desktop
    discord
    signal-desktop
    # qq

    motrix
    appimage-run
  ];

  services.gpg-agent = {
    enable = true;
    enableSshSupport = true;
    enableFishIntegration = true;
  };
}
