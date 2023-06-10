{config, ...}: let
  d = config.xdg.dataHome;
  c = config.xdg.configHome;
  cache = config.xdg.cacheHome;
in rec {
  imports = [
    ./common.nix
    ./terminals.nix
  ];

  programs.fish = {
    enable = true;
    shellAliases = {
      ll = "ls -l";
    };

    # plugins = [
    #   # Need this when using Fish as a default shell in order to pick
    #   # up ~/.nix-profile/bin
    #   {
    #     name = "nix-env";
    #     src = pkgs.fetchFromGitHub {
    #       owner = "lilyball";
    #       repo = "nix-env.fish";
    #       rev = "00c6cc762427efe08ac0bd0d1b1d12048d3ca727";
    #       sha256 = "1hrl22dd0aaszdanhvddvqz3aq40jp9zi2zn0v1hjnf7fx4bgpma";
    #     };
    #   }
    # ];

    # shellInit = ''
    #   fish_add_path $HOME/.local/bin
    #   zoxide init fish | source
    #   set -Ux PYENV_ROOT $HOME/.pyenv
    #   fish_add_path $PYENV_ROOT/bin
    #   pyenv init - | source
    #   fish_add_path $HOME/.emacs.d/bin
    #   fish_add_path $HOME/.cargo/bin
    #   fish_add_path $HOME/.ghcup/bin
    #   fish_add_path $HOME/.cabal/bin
    #   fish_add_path $HOME/.pack/bin
    #   source $HOME/.opam/opam-init/init.fish > /dev/null 2> /dev/null; or true
    # '';

    # interactiveShellInit = ''
    #   set --global VISUAL "emacs"
    #   set --global EDITOR "vim"
    # '';
  };

  # programs.bash = {
  #   enable = true;
  #   enableCompletion = true;
  #   bashrcExtra = ''
  #     export PATH="$PATH:$HOME/bin:$HOME/.local/bin:$HOME/go/bin"
  #   '';
  # };

  # add environment variables
  systemd.user.sessionVariables = {
    # clean up ~
    LESSHISTFILE = cache + "/less/history";
    LESSKEY = c + "/less/lesskey";
    WINEPREFIX = d + "/wine";
    XAUTHORITY = "$XDG_RUNTIME_DIR/Xauthority";

    # set default applications
    BROWSER = "firefox";
    TERMINAL = "kitty";

    # enable scrolling in git diff
    DELTA_PAGER = "less -R";

    MANPAGER = "sh -c 'col -bx | bat -l man -p'";
  };

  home.sessionVariables = systemd.user.sessionVariables;

  home.shellAliases = {
    # k = "kubectl";
  };
}
