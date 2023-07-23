{pkgs, config, ...}:

{
  home.packages = with pkgs; [
    kitty
    git
    neovim
    vscode
    firefox
    nil
    nixpkgs-fmt
    direnv

    wget
    neofetch
    btop
    nvtop
    du-dust # Dist Usage rewritten in rust

    ripgrep
    # command-line YAML, JSON and XML processor
    # https://github.com/mikefarah/yq
    yq-go
    exa
    nnn
    fd
    sd

    jetbrains.pycharm-community
    jetbrains.idea-community

    texlive.combined.scheme-full
    typst
    graphviz
    pandoc
    zathura

    gcc
    clang-tools
    clang-analyzer
    lldb
    cmake

    telegram-desktop
    discord
    signal
    qq
  ];

  programs = {
    tmux = {
      enable = true;
    };

    # modern vim
    neovim = {
      enable = true;
      defaultEditor = true;
      extraConfig = ''
        set number relativenumber
        set autoindent expandtab tabstop=2 shiftwidth=2
      '';
    };

    bat = {
      enable = true;
      config = {
        pager = "less -FR";
        theme = "Catppuccin-mocha";
      };
      themes = {
        Catppuccin-mocha = builtins.readFile (pkgs.fetchurl {
          url = "https://raw.githubusercontent.com/catppuccin/bat/main/Catppuccin-mocha.tmTheme";
          # hash = "sha256-qMQNJGZImmjrqzy7IiEkY5IhvPAMZpq0W6skLLsng/w=";
          hash = "0";
        });
      };
    };

    # Basically anywhere you would want to use grep, try sk instead.
    skim = {
      enable = true;
      enableFishIntegration = true;
    };

    zoxide = {
      enable = true;
      enableFishIntegration = true;
    };

    keychain = {
      enable = true;
      keys = [ "id_ed25519" ];
    };

    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };

    helix = {
      enable = true;
    };

    fish = {
      enable = true;
      shellInit = ''
        fish_add_path $HOME/.cargo/bin
        fish_add_path $HOME/.ghcup/bin
        fish_add_path $HOME/.cabal/bin
        source $HOME/.opam/opam-init/init.fish > /dev/null 2> /dev/null; or true
      '';
    };

    programs.git = {
      enable = true;
      userName = "Zijun Yu";
      userEmail = "zijun.yu.joey@gmail.com";
    };
  };

  home.shellAliases = {
    ls = "exa";
    ll = "exa -l";
    tree = "exa --tree";
    treel = "exa --tree --long";
  };

  # systemd.user.sessionVariables = {
  #   # clean up ~
  #   LESSHISTFILE = config.xdg.cacheHome + "/less/history";
  #   LESSKEY = config.xdg.configHome + "/less/lesskey";
  #   WINEPREFIX = config.xdg.dataHome + "/wine";
  #   XAUTHORITY = "$XDG_RUNTIME_DIR/Xauthority";

  #   # set default applications
  #   BROWSER = "firefox";
  #   TERMINAL = "kitty";

  #   # enable scrolling in git diff
  #   DELTA_PAGER = "less -R";

  #   MANPAGER = "sh -c 'col -bx | bat -l man -p'";
  # };

  # # the variable systemd is recursing here
  # home.sessionVariables = systemd.user.sessionVariables;
}
