{ pkgs, lib, nixos-hardware, ... }:

with lib;
with lib.mynix;
{
  imports = [ ./hardware.nix ];

  networking.hostName = "e490";

  mynix = {
    archetypes = {
      workstation = enabled;
    };

    system.fs = { 
      ephemeral-root-btrfs = enabled;
      encrypted-root = enabled;
    };

    user = {
      name = "dougw";
      email = "dweimer@gmail.com";
      uid = 1000;
      extraGroups = [ "wheel" ];
      extraOptions = {
        passwordFile = "/persist/secrets/dougw-pw";
      };
    };

  };

  # Use a larger console font for the smaller screen
  console.font = lib.mkDefault "${pkgs.terminus_font}/share/consolefonts/ter-128b.psf.gz";
  
  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?
}
