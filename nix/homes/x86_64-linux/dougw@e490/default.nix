{ lib, pkgs, inputs, config, osConfig ? { }, format ? "unknown", ... }:

with lib.mynix;
{
  imports = [
    inputs.impermanence.nixosModules.home-manager.impermanence
  ];
  home = {
    username = "dougw";
    homeDirectory = "/home/dougw";

    persistence = {
      "/persist/root/home/dougw" = {
        directories = [
          "Documents"
          "Downloads"
        ];
        allowOther = true;
      };
    };
  };
}
