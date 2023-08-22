{ pkgs, lib, config, ... }:
{
  imports = [ ./packages.nix ];

  users.mutableUsers = false;
  users.users.dougw = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "networkmanager"
#      "video"
#      "audio"
    ];
    passwordFile = "/persist/secrets/dougw-pw";
  };

#  sops.secrets.layla-password = {
#    sopsFile = ../../secrets.yaml;
#    neededForUsers = true;
#  };

  # Per user persistence is handled by home-manager
  environment.persistence = { };

  home-manager.users.dougw = import ../../../../home/dougw/${config.networking.hostName}.nix;

  security.pam.services = {
    swaylock = {};
  };
}