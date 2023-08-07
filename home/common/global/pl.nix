{pkgs, config, ...}:

{
  home.packages = with pkgs; [
    cmake

    jdk

    (python310.withPackages (p: with p;[ jupyter pygments pandas matplotlib flask ]))
    poetry

    nodejs
    yarn
    nodePackages.typescript

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
}
