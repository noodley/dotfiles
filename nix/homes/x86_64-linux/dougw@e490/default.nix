{ lib, pkgs, inputs, config, osConfig ? { }, format ? "unknown", ... }:

with lib.mynix;
{
  imports = [
    inputs.impermanence.nixosModules.home-manager.impermanence
  ];

  programs = {
    bash = {
      enable = true;
      shellAliases = {
        vimdiff = "nvim -d";
        vi = "nvim";
        vim = "nvim";
      };
      shellOptions = [ ];
      bashrcExtra = ''
        set -o vi
      '';
      historyFile = "/persist/root/home/dougw/.bash_history";
      historyIgnore = [
        "ls"
        "exit"
      ];
    };
  };

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
