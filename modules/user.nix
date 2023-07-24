{config, pkgs, user, ...}:

{
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.${user} = {
    isNormalUser = true;
    description = "Zijun Yu";

    extraGroups = [ "networkmanager" "wheel" "video" ];
    # extraGroups = [ "users" "networkmanager" "wheel" "docker" "wireshark" "adbusers" ];
    # initialHashedPassword = "$y$j9T$5znC98MZa.TIDST9JM3jz/$7tdOFtbwL8tHCdhg1c8bJZnCGUYm51DLzUj8rAHobO6";
    openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBRCof2pErzjwNhAuJJZNXd/4Se4XUMwg+e2cDl1PwDY"
    ];

    shell = pkgs.fish;
  };

  programs.fish.enable = true;
  environment.shells = with pkgs; [ fish ];
}
