# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../common/packages.nix
    ../common/nvidia.nix
    ../common/user.nix
    ../common/virtualisation/docker.nix
    ../common/fonts.nix
    ../common/desktop/wine.nix
    # ../common/desktop/hyprland.nix
  ];

  nix = {
    settings = {
      experimental-features = [ "nix-command" "flakes" ];
      auto-optimise-store = false;
    };
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 2w";
    };
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # nixpkgs.overlays = import ../../overlays args;

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.supportedFilesystems = [ "ntfs" ];

  networking.hostName = "y7000"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Copenhagen";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_GB.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_GB.UTF-8";
    LC_IDENTIFICATION = "en_GB.UTF-8";
    LC_MEASUREMENT = "en_GB.UTF-8";
    LC_MONETARY = "en_GB.UTF-8";
    LC_NAME = "en_GB.UTF-8";
    LC_NUMERIC = "en_GB.UTF-8";
    LC_PAPER = "en_GB.UTF-8";
    LC_TELEPHONE = "en_GB.UTF-8";
    LC_TIME = "en_GB.UTF-8";
  };

  # Enable the X11 windowing system.
  # services.xserver.enable = true;

  # Enable the GNOME Desktop Environment.
  # services.xserver.displayManager.gdm.enable = true;
  # services.xserver.desktopManager.gnome.enable = true;

  # services.xserver.displayManager.sddm.enable = true;
  # services.xserver.desktopManager.plasma5.enable = true;
  # services.xserver.displayManager.lightdm.enable = true;

  services.upower.enable = true;
  services.xserver = {
    enable = true;
    desktopManager.plasma5.enable = true;
    displayManager = {
      lightdm = {
        enable = true;
        greeters.enso = {
          enable = true;
          blur = true;
          # extraConfig = ''
          #   default-wallpaper=/usr/share/streets_of_gruvbox.png
          # '';
        };
      };
    };

    layout = "us";
    xkbVariant = "";
    xkbOptions = "caps:ctrl_modifier";
  };

  # services = {
  #   gnome.gnome-keyring.enable = true;
  #   upower.enable = true;
  #
  #   dbus = {
  #     enable = true;
  #     packages = [ pkgs.dconf ];
  #   };
  #
  #   autorandr.enable = true;
  #
  #   xserver = {
  #     enable = true;
  #     autorun = true;
  #
  #     windowManager.xmonad = {
  #       enable = true;
  #       enableContribAndExtras = true;
  #     };
  #
  #     displayManager = {
  #       defaultSession = "none+xmonad";
  #       lightdm = {
  #         greeters.enso = {
  #           enable = true;
  #           blur = true;
  #           # extraConfig = ''
  #           #   default-wallpaper=/usr/share/streets_of_gruvbox.png
  #           # '';
  #         };
  #       };
  #       # sessionCommands = ''
  #       #   xrandr --output VGA-0 --mode 1400x900 --pos 2560x336 --rotate normal --output DVI-D-0 --off --output HDMI-0 --primary --mode 2560x1440 --pos 0x0 --rotate normal
  #       #   ./.fehbg
  #       #   '';
  #     };
  #
  #     layout = "us";
  #     xkbVariant = "";
  #     xkbOptions = "caps:ctrl_modifier";
  #
  #     # xrandrHeads = [{output = "HDMI-0";primary = true;}{output = "VGA-0";}];
  #   };
  # };

  systemd.services.upower.enable = true;

  # Enable CUPS to print documents.
  services.printing.enable = true;
  # Needed to find wireless printer
  services.avahi = {
    enable = true;
    nssmdns = true;
    # Needed for detecting the scanner
    publish = {
      enable = true;
      addresses = true;
      userServices = true;
    };
  };

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    # jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    # media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  services.xserver.libinput = {
    enable = true;
    touchpad.disableWhileTyping = true;

    # disabling mouse acceleration
    # mouse = {
    #   accelProfile = "flat";
    # };

    # disabling touchpad acceleration
    # touchpad = {
    #   accelProfile = "flat";
    # };
  };

  # Laptop does not go to sleep when lid is closed
  services.logind.lidSwitch = "ignore";

  hardware.bluetooth.enable = true;
  services.blueman.enable = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
  ];

  environment.variables.EDITOR = "nvim";

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh = {
    enable = true;
    settings = {
      PermitRootLogin = "no";
      PasswordAuthentication = false;
    };
  };

  # https://flatpak.org/setup/NixOS
  # services.flatpak.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?
}
