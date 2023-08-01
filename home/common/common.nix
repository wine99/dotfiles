{ pkgs, config, user, ... }:

{
  home.packages = with pkgs; [
    firefox
    nil
    nixpkgs-fmt
    direnv
    nvfetcher

    any-nix-shell

    wget
    neofetch
    btop
    nvtop
    du-dust # Dist Usage rewritten in rust

    ranger
    ripgrep
    # command-line YAML, JSON and XML processor
    # https://github.com/mikefarah/yq
    yq-go
    exa
    fd
    sd
    grc

    jetbrains.pycharm-community
    jetbrains.idea-community

    texlive.combined.scheme-full
    typst
    graphviz
    pandoc
    zathura

    gnumake
    gcc
    clang-tools
    clang-analyzer
    lldb
    cmake

    telegram-desktop
    discord
    signal-desktop
    qq

    yt-dlp
    motrix
    appimage-run
    file
  ];

  programs = {
    tmux = {
      enable = true;
    };

    neovim = {
      enable = true;
      defaultEditor = true;
      extraConfig = ''
        set number relativenumber
        set autoindent expandtab tabstop=2 shiftwidth=2
      '';
    };

    vscode = {
      enable = true;
      extensions = with pkgs; [
        vscode-extensions.ms-vscode.cpptools
      ];
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
          hash = "sha256-qMQNJGZImmjrqzy7IiEkY5IhvPAMZpq0W6skLLsng/w=";
        });
      };
    };

    # nnn = {
    #   enable = true;
    #   package = pkgs.nnn.override { withNerdIcons = true; };
    #   plugins = {
    #     src = (pkgs.fetchFromGitHub {
    #       owner = "jarun";
    #       repo = "nnn";
    #       rev = "v4.0";
    #       sha256 = "sha256-dAoXn0+muTuml9s6WXsv7LSY6p2hy8/G1XsBmbR+fTE=";
    #     }) + "/plugins";
    #   };
    # };

    # Basically anywhere you would want to use grep, try sk instead.
    skim = {
      enable = true;
      enableFishIntegration = true;
    };

    zoxide = {
      enable = true;
      enableFishIntegration = true;
    };

    fzf = {
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
        any-nix-shell fish --info-right | source
      '';

      plugins = [
        { name = "grc"; src = pkgs.fishPlugins.grc.src; }
      ];
    };

    starship = {
      enable = true;
      enableFishIntegration = true;
      settings = {
        character = {
          success_symbol = "[λ](bold green)";
          error_symbol = "[λ](bold red)";
        };
      };
    };

    kitty = {
      enable = true;
      theme = "Catppuccin-Mocha";
      font = {
        name = "FiraCode Nerd Font";
        size = 14;
      };

      settings = {
        shell_integration = "no-cursor";
        background_opacity = "0.9";
        scrollback_lines = 10000;
        enable_audio_bell = false;
      };

      keybindings = {
        # Trick: type `kitty +kitten show_key` in kitty
        # "ctrl+backspace" = "send_text all \x17";   # ctrl+w
        "ctrl+backspace" = "send_text all \\x1b\\x7f"; # alt+backspace

      };
    };

    git = {
      enable = true;
      userName = "Zijun Yu";
      userEmail = "zijun.yu.joey@gmail.com";
    };
  };

  home.shellAliases = {
    # ls = "nnn -e";
    # ll = "nnn -de";
    ls = "exa";
    ll = "exa --long";
    tree = "exa --tree";
    treel = "exa --tree --long";
  };

  home.file.".config/fish/conf.d/mocha.fish".text = import ./fish_theme.nix;

  home.file.".background-iamge".source = ./../wallpapers/wallpaper.png;

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
