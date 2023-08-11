{ inputs, lib, pkgs, config, outputs, ... }:
let
  inherit (inputs.nix-colors) colorSchemes;
  inherit (inputs.nix-colors.lib-contrib { inherit pkgs; }) colorschemeFromPicture nixWallpaperFromScheme;
in
{
  imports = [
    inputs.impermanence.nixosModules.home-manager.impermanence
    #inputs.nix-colors.homeManagerModule
    #../features/cli
    #../features/nvim
  ] ++ (builtins.attrValues outputs.homeManagerModules);

  # TODO: Only enable this on hosts where useGlobalPackages is not configured
  #nixpkgs = {
  #  overlays = builtins.attrValues outputs.overlays;
  #  config = {
  #    allowUnfree = true;
  #    allowUnfreePredicate = (_: true);
  #    permittedInsecurePackages = [ ];
  #  };
  #};

  #nix = {
  #  package = lib.mkDefault pkgs.nix;
  #  settings = {
  #    experimental-features = [ "nix-command" "flakes" "repl-flake" ];
  #    warn-dirty = false;
  #  };
  #};

  #systemd.user.startServices = "sd-switch";

  programs = {
    home-manager.enable = true;
    bash = {
      enable = true;
      shellAliases = {
        vi = "nvim";
        vim = "nvim";
      };
      shellOptions = [ ];
      bashrcExtra = ''
        set -o vi
      '';
    };
    git = {
      enable = true;
      userName = "Doug Weimer";
      userEmail = "dweimer@gmail.com";
      extraConfig = {
        core = {
          editor = "nvim";
        };
      };
    };
    tmux = {
      enable = true;
      keyMode = "vi";
    };
  };

  home = {
    username = lib.mkDefault "dougw";
    homeDirectory = lib.mkDefault "/home/${config.home.username}";
    stateVersion = lib.mkDefault "23.05";
    sessionPath = [ ];

    persistence = {
      "/persist/root/home/${config.home.username}" = {
        directories = [
	  ".ssh"
          "Documents"
          "Downloads"
        ];
	files = [
	  ".bash_history"
	];
        allowOther = true;
      };
    };
  };
}
