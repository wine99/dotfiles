# template from https://github.com/Misterio77/nix-starter-configs/

# This is your home-manager configuration file
# Use this to configure your home environment (it replaces ~/.config/nixpkgs/home.nix)

{ inputs, outputs, lib, config, pkgs, username, ... }: {
  # You can import other home-manager modules here
  imports = [
    # If you want to use modules your own flake exports (from modules/home-manager):
    # outputs.homeManagerModules.example

    # Or modules exported from other flakes (such as nix-colors):
    # inputs.nix-colors.homeManagerModules.default

    # You can also split up your configuration and import pieces of it here:
    ./common/linux
    ./common/global
    ./fcitx5
  ];

  targets.genericLinux.enable = true;

  nix = {
    package = pkgs.nix;
    settings.experimental-features = [ "nix-command" "flakes" ];
  };

  nixpkgs.overlays = [
      inputs.nixgl.overlay

      # https://www.reddit.com/r/NixOS/comments/scf0ui/how_would_i_update_desktop_file/
      # (final: prev: {
      #   kitty = prev.kitty.overrideAttrs (oldAttrs: {
      #     postInstall = (oldAttrs.postInstall or "") + ''
      #       substituteInPlace $out/share/applications/kitty.desktop \
      #         --replace "Exec=kitty" "Exec=nixGLIntel kitty"
      #     '';
      #   });
      # })
  ];

  fonts.fontconfig.enable = true;

  home.packages = with pkgs; [
    vscode
    nixgl.nixGLIntel
    (nerdfonts.override {
      fonts = [
        "FiraCode"
        "JetBrainsMono"
        "Iosevka"
      ];
    })
  ];
}
