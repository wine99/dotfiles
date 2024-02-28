{ inputs, outputs, lib, config, pkgs, username, ... }: {
  imports = [
    ./common/linux
    ./common/global
  ];

  targets.genericLinux.enable = true;

  nix = {
    package = pkgs.nix;
    settings.experimental-features = [ "nix-command" "flakes" ];
  };

  fonts.fontconfig.enable = true;

  # https://blog.codeminer42.com/securing-git-commits-on-windows-10-and-wsl2/
  services.gpg-agent.extraConfig = ''
    pinentry-program "/mnt/c/Program Files (x86)/GnuPG/bin/pinentry-basic.exe"
  '';
}
