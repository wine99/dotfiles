# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).


{ config, pkgs, home-manager, ... } @ args:

{
  imports = [
    ./hardware-configuration.nix
    ../../modules/hardware
    ../../modules/user_group.nix
    ../../modules/services
    ../../modules/fonts.nix
    ../../modules/desktop/hyprland.nix
  ];

  nixpkgs.config.allowUnfree = true;
  # nixpkgs.overlays = import ../../overlays args;

  nix = {
    settings = {
      experimental-features = [ "nix-command" "flakes" ];
      auto-optimise-store = true;
    };
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 1w";
    };
  };

  boot = {
    supportedFilesystems = [ "ntfs" ];
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
    kernelParams = [
      "quiet"
      "splash"
    ];
  };

  networking = {
    hostName = "y7000";
    networkmanager.enable = true;
  };

  # Set your time zone.
  time.timeZone = "Europe/Copenhagen";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  security.polkit.enable = true;

  services.printing.enable = true;

  sound.enable = true;
  hardware.pulseaudio.enable = false;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  services.openssh = {
    enable = true;
    settings = {
      PermitRootLogin = "no";
      PasswordAuthentication = false;
    };
  };

  services.power-profiles-daemon.enable = true;

  services.dbus.packages = [ pkgs.gcr ];

  services.geoclue2.enable = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.shells = [ pkgs.fish ];
  environment.variables.EDITOR = "nvim";
  environment.systemPackages = with pkgs; [
    git
    neovim
    wget
    curl
    neofetch
    killall

    # networking tools
    # ethtool
    # iperf3
    # nmap
    # socat

    # system tools
    # sysstat
    # lm_sensors  # for `sensors` command

    # misc
    # findutils
    # file
    # which
    # tree
    # gnused
    # gnutar
    # gawk
    # p7zip
    # xz
    # zstd
    # cifs-utils  # for mounting windows shares

    # (python3.withPackages(ps: with ps; [
    #   ipython
    #   pandas
    #   requests
    #   pyquery
    # ]))

    # need to run `conda-install` before using it
    # need to run `conda-shell` before using command `conda`
    # conda

    # video/audio tools

    vdpauinfo
    vulkan-tools
    glxinfo
    glmark2

    # minimal screen capture tool, used by i3 blur lock to take a screenshot
    # print screen key is also bound to this tool in i3 config
    # scrot

    # xfce.thunar  # xfce4's file manager
    # xdg-user-dirs

    # embedded development
    # minicom

    # remote desktop(rdp connect)
    # remmina
    # freerdp  # required by remmina

    # devenv.packages."${pkgs.system}".devenv
  ];

  # https://flatpak.org/setup/NixOS
  # services.flatpak.enable = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?
}
