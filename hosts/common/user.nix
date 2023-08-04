{ config, pkgs, username, ... }:

{
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.${username} = {
    isNormalUser = true;
    description = "Zijun Yu";

    extraGroups = [ "networkmanager" "wheel" "video" ];
    initialHashedPassword = "$y$j9T$5znC98MZa.TIDST9JM3jz/$7tdOFtbwL8tHCdhg1c8bJZnCGUYm51DLzUj8rAHobO6";
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBRCof2pErzjwNhAuJJZNXd/4Se4XUMwg+e2cDl1PwDY"
    ];

    shell = pkgs.fish;
  };

  programs.fish.enable = true;
  environment.shells = with pkgs; [ fish ];
}
