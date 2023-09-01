{ lib, pkgs, inputs, config, osConfig ? { }, format ? "unknown", ... }:

with lib.mynix;
{
  imports = [
    inputs.impermanence.nixosModules.home-manager.impermanence
  ];

  mynix = {
    suites = {
      common = enabled;
    };

    desktop = {
      sway = enabled;
    };
  };

  programs = {
    bash = {
      enable = true;
      shellAliases = { };
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
    git = {
      enable = true;
      userName = "Doug Weimer";
      userEmail = "dweimer@gmail.com";
      #lfs = enabled;
      signing = {
        key = "6129D14861D5C62E";
        signByDefault = true;
      };
      extraConfig = {
        init = { defaultBranch = "main"; };
        pull = { rebase = true; };
        push = { autoSetupRemote = true; };
        core = { 
          whitespace = "trailing-space,space-before-tab"; 
          editor = "nvim";
        };
      };
    };

    home-manager = {
      enable = true;
    };
  };

  home = {
    username = "dougw";
    homeDirectory = "/home/dougw";
    stateVersion = "23.05";

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
