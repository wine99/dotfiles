{ pkgs, ... }: {
  home.packages = with pkgs; [

    # Removed all GUI apps: fcitx5 installed by pacman does not work in GUI apps installed by nix

    # gnumake
    # gcc
    # clang-tools
    # clang-analyzer
    # lldb

    # nvtop
    # google-chrome
    # firefox

    # zotero

    # jetbrains.pycharm-professional
    # jetbrains.idea-ultimate

    # telegram-desktop
    # discord
    # signal-desktop
    # qq

    # motrix
    # appimage-run
  ];

  services.gpg-agent = {
    enable = true;
    enableSshSupport = true;
    enableFishIntegration = true;
  };
}
