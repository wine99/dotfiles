{
  pkgs,
  ...
}: {
  home.packages = [pkgs.gh];

  programs.git = {
    enable = true;

    userName = "Zijun Yu";
    userEmail = "zijun.yu.joey@gmail.com";
  };
}
