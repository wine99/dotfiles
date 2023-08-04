{ config, pkgs, username, ... }:

{
  virtualisation.docker = {
    enable = true;
    enableNvidia = true;
    # storageDriver = "btrfs";
  };
  users.groups.docker.members = [ "${username}" ];
  environment.systemPackages = with pkgs; [
    docker-compose
  ];
}
