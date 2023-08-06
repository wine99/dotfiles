{ pkgs, ... }: {
  home.packages = with pkgs; [
    gnumake
    gcc
    # clang-tools
    # clang-analyzer
    # lldb

    nvtop
    firefox

    jetbrains.pycharm-community
    jetbrains.idea-community

    telegram-desktop
    discord
    signal-desktop
    # qq

    motrix
    appimage-run
  ];

  programs = {
    vscode = {
      enable = true;
      extensions = with pkgs; [
        vscode-extensions.ms-vscode.cpptools
      ];
    };
  };

  services.ssh-agent.enable = true;
}
