# https://nixos.wiki/wiki/Nvidia

{ config, lib, pkgs, ... }:

{
  # Make sure opengl is enabled
  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
    extraPackages = with pkgs; [
      intel-media-driver
      vaapiIntel
      nvidia-vaapi-driver
      vaapiVdpau
      libvdpau-va-gl
    ];
  };

  # Tell Xorg to use the nvidia driver (also valid for Wayland)
  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.nvidia = {

    # Modesetting is needed for most Wayland compositors
    modesetting.enable = true;

    # Use the open source version of the kernel module
    # Only available on driver 515.43.04+
    open = false;

    # Enable the nvidia settings menu
    nvidiaSettings = true;

    # Optionally, you may need to select the appropriate driver version for your specific GPU.
    # package = config.boot.kernelPackages.nvidiaPackages.vulkan_beta;

    prime = {
      intelBusId = "PCI:00:02:0";
      nvidiaBusId = "PCI:01:00:0";
      sync.enable = true;
      # offload = {
      #   enable = true;
      #   enableOffloadCmd = true;
      # };
    };

    # powerManagement.enable = true;
    # powerManagement.finegrained = true;
  };

  specialisation = {
    nvidia-prime.configuration = {
      system.nixos.tags = [ "nvidia-prime" ];
      hardware.nvidia = {
        prime.sync.enable = lib.mkForce false;
        prime.offload.enable = lib.mkForce true;
        prime.offload.enableOffloadCmd = lib.mkForce true;
        powerManagement.enable = lib.mkForce true;
      };
    };
  };

  environment.systemPackages = with pkgs; [
    lshw
    pciutils
    glxinfo
  ];

  # services.power-profiles-daemon.enable = false;
  # services.tlp.enable = true;
  # services.auto-cpufreq.enable = true;
}
