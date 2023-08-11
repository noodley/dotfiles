{ inputs, lib, pkgs, config, outputs, ... }:
{
  imports = [
    inputs.impermanence.nixosModules.home-manager.impermanence
    ../features/cli
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
  #
  #nix = {
  #  package = lib.mkDefault pkgs.nix;
  #  settings = {
  #    experimental-features = [ "nix-command" "flakes" "repl-flake" ];
  #    warn-dirty = false;
  #  };
  #};

  programs = {
    home-manager.enable = true;
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
