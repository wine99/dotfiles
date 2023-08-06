{ pkgs, username, ... }: {
  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = with pkgs; [
    neovim
  ];
  environment.variables.EDITOR = "nvim";

  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;
  # nix.package = pkgs.nix;

  nix = {
    settings = {
      experimental-features = [ "nix-command" "flakes" ];
      auto-optimise-store = true;
    };
    gc = {
      automatic = true;
      options = "--delete-older-than 2w";
    };
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Create /etc/zshrc that loads the nix-darwin environment.
  programs.zsh.enable = true;  # default shell on catalina
  # programs.fish.enable = true;

  # Set Git commit hash for darwin-version.
  # system.configurationRevision = self.rev or self.dirtyRev or null;

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 4;

  # The platform the configuration will be used on.
  nixpkgs.hostPlatform = "aarch64-darwin";

  system = {
    # defaults = {
    #   ".GlobalPreferences" = {
    #     "com.apple.mouse.scaling" = -1.0;
    #   };
    #   NSGlobalDomain = {
    #     "com.apple.swipescrolldirection" = false;
    #   };
    # };
    keyboard = {
      enableKeyMapping = true;
      remapCapsLockToControl = true;
    };
  };

  programs.fish.enable = true;
  users.users.${username}.shell = pkgs.fish;
  environment.shells = with pkgs; [ fish ];

  homebrew = {
    enable = true;
    # global.brewfile = true;
    onActivation.cleanup = "uninstall";
    taps = [ "homebrew/cask" ];
    brews = [];
    casks = [
      "raycast"
      "moom"
      "firefox"
      "visual-studio-code"
      "spotify"
      "siyuan"
      "obsidian"
      "pdf-expert"
      "zoom"
      "zotero"
      "motrix"
      "discord"
      "orbstack"
      "drawio"
      "google-chrome"
      "intellij-idea"
      "pycharm"
    ];
  };

  fonts.fontDir.enable = true;
  fonts.fonts = with pkgs; [
    material-icons
    fira
    (nerdfonts.override {
      fonts = [
        "FiraCode"
        "JetBrainsMono"
        "Iosevka"
      ];
    })
  ];
}
