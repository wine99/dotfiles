{ pkgs, config, ... }:

{
  home.packages = with pkgs; [
    cmake

    # (python311.withPackages (p: with p;[ jupyter pygments pandas matplotlib ]))
    poetry

    nodejs
    yarn
    nodePackages.typescript
    nodePackages.vue-cli

    rustup

    go

    # opam

    # racket

    # haskellPackages.ghcup
    # stack
    # ghc
    # haskell-language-server

    # nixpkgs-fmt
    nixfmt
    # nil
    rnix-lsp
    shellcheck
  ];

  programs.java = {
    enable = true;
    package = pkgs.jdk21;
  };
}
