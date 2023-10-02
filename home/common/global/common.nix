{ pkgs, config, username, ... }:

{
  home.packages = with pkgs; [
    direnv
    # nvfetcher
    any-nix-shell

    gnupg
    wget
    neofetch
    btop
    du-dust # Dist Usage rewritten in rust
    file

    ranger
    gawk
    ripgrep
    # command-line YAML, JSON and XML processor
    # https://github.com/mikefarah/yq
    yq-go
    eza
    fd
    sd
    grc
    lazygit
    pre-commit

    pkg-config
    postgresql
    protobuf
    unixODBC

    texlive.combined.scheme-full
    typst
    graphviz
    pandoc
    zathura

    yt-dlp
    lux

    gimp
    viu
    # playerctl
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

    # joshuto = {
    #   enable = true;
    # };

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

    # keychain = {
    #   enable = true;
    #   keys = [ "id_ed25519" ];
    # };

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
        git_status = {
          ahead = "⇡$\{count\}";
          diverged = "⇡$\{ahead_count\}⇣$\{behind_count\}";
          behind = "⇣$\{count\}";
          modified = "!$\{count\}";
          untracked = "?$\{count\}";
          staged = "+$\{count\}";
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

  };

  home.shellAliases = {
    # ls = "nnn -e";
    # ll = "nnn -de";
    ls = "eza";
    ll = "eza --long";
    tree = "eza --tree";
    treel = "eza --tree --long";
  };

  home.file.".config/fish/conf.d/mocha.fish".text = import ./fish_theme.nix;

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
