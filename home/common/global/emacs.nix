{ inputs, pkgs, ... }: {
  imports = [ inputs.nix-doom-emacs.hmModule ];
  services.emacs.enable = if pkgs.stdenv.isDarwin then false else true;
  programs.doom-emacs = {
    enable = true;
    doomPrivateDir = ./doom.d;
  };
  programs.fish.interactiveShellInit = ''
    set --global ALTERNATE_EDITOR "nvim"
    set --global EDITOR "emacsclient -t"
    set --global VISUAL "emacsclient -c -a emacs"
  '';
}
