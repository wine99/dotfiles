{pkgs, config, ...}:

{
  home.packages = with pkgs; [
    jdk

    # (python310.withPackages (p: with p;[ jupyter pygments pandas matplotlib flask ]))
    # poetry
    # streamlit

    nodejs
    yarn
    nodePackages.typescript

    rustup

    opam

    # racket

    # haskellPackages.ghcup
    # stack
    # ghc
    # haskell-language-server

    nixpkgs-fmt
    nil
    shellcheck
  ];
}
