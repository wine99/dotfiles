{ config, lib, pkgs, ... }:

let
  nvidia-offload = pkgs.writeShellScriptBin "nvidia-offload" ''
    export __NV_PRIME_RENDER_OFFLOAD=1
    export __NV_PRIME_RENDER_OFFLOAD_PROVIDER=NVIDIA-G0
    export __GLX_VENDOR_LIBRARY_NAME=nvidia
    export __VK_LAYER_NV_optimus=NVIDIA_only
    exec "$@"
  '';
in
{
  # Make sure opengl is enabled
  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
    # extraPackages = with pkgs; [
    #   intel-media-driver
    #   vaapiIntel
    #   nvidia-vaapi-driver
    #   vaapiVdpau
    #   libvdpau-va-gl
    # ];
  };

  # NVIDIA drivers are unfree.
  nixpkgs.config.allowUnfreePredicate = pkg:
    builtins.elem (lib.getName pkg) [
      "nvidia-x11"
      "nvidia-settings"
    ];

  # Tell Xorg to use the nvidia driver
  services.xserver.videoDrivers = ["nvidia"];

  hardware.nvidia = {

    # Modesetting is needed for most wayland compositors
    modesetting.enable = false;

    # Use the open source version of the kernel module
    # Only available on driver 515.43.04+
    # open = false;

    # Enable the nvidia settings menu
    nvidiaSettings = true;

    # Optionally, you may need to select the appropriate driver version for your specific GPU.
    # package = config.boot.kernelPackages.nvidiaPackages.stable;

    # prime = {
    #   offload.enable = true;
    #   intelBusId = "PCI:00:02:0";
    #   nvidiaBusId = "PCI:01:00:0";
    # };

    powerManagement = {
      enable = true;
      # finegrained = true;
    };
  };

  environment = {
    systemPackages = with pkgs; [
      # nvidia-offload
      # libva
      # libva-utils
      glxinfo
      pciutils
    ];
  };

  # services = {
  #   # tlp.enable = true;
  #   # auto-cpufreq.enable = true;
  #   xserver.videoDrivers = [ "nvidia" ];
  # };
  # boot.kernelParams = [
  #   "nvidia-drm.modeset=1"
  # ];
  # hardware = {
  #   nvidia = {
  #     open = false;
  #     # package = config.boot.kernelPackages.nvidiaPackages.vulkan_beta;
  #     # package = config.boot.kernelPackages.nvidiaPackages.stable;
  #     modesetting.enable = true;
  #     prime = {
  #       offload.enable = true;
  #       intelBusId = "PCI:00:02:0";
  #       nvidiaBusId = "PCI:01:00:0";
  #     };
  #     # powerManagement.enable = true;
  #   };
  #   opengl = {
  #     enable = true;
  #     driSupport = true;
  #     driSupport32Bit = true;
  #     extraPackages = with pkgs; [
  #       intel-media-driver
  #       vaapiIntel
  #       nvidia-vaapi-driver
  #       vaapiVdpau
  #       libvdpau-va-gl
  #     ];
  #   };
  #   pulseaudio.support32Bit = true;
  # };
  # environment = {
  #   systemPackages = with pkgs; [
  #     nvidia-offload
  #     libva
  #     libva-utils
  #     glxinfo
  #   ];
  # };
}
