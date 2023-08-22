{ options, config, pkgs, lib, inputs, ... }:

with lib;
with lib.mynix;
let
  cfg = config.mynix.nix;

  substituters-submodule = types.submodule ({ name, ... }: {
    options = with types; {
      key = mkOpt (nullOr str) null "The trusted public key for this substituter.";
    };
  });
in
{
  options.mynix.nix = with types; {
    enable = mkBoolOpt true "Whether or not to manage nix configuration.";
    package = mkOpt package pkgs.nixUnstable "Which nix package to use.";

    default-substituter = {
      url = mkOpt str "https://cache.nixos.org" "The url for the substituter.";
      key = mkOpt str "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY=" "The trusted public key for the substituter.";
    };

    extra-substituters = mkOpt (attrsOf substituters-submodule) { } "Extra substituters to configure.";
  };

  config = mkIf cfg.enable {
    assertions = mapAttrsToList
      (name: value: {
        assertion = value.key != null;
        message = "mynix.nix.extra-substituters.${name}.key must be set";
      })
      cfg.extra-substituters;

    environment.systemPackages = with pkgs; [
      nixfmt
      nix-index
      nix-prefetch-git
      nix-output-monitor
    ];

    nix =
     let 
       users = [ "root" "@wheel" ];
     in
      {
        package = cfg.package;

        settings = {
          experimental-features = [ "nix-command" "flakes" "repl-flake" ];
          http-connections = 50;
          warn-dirty = false;
          log-lines = 50;
          auto-optimise-store = true;
          trusted-users = users;
          allowed-users = users;
	  system-features = [ "kvm" "big-parallel" "nixos-test" ];

          substituters =
            [ cfg.default-substituter.url ]
              ++
              (mapAttrsToList (name: value: name) cfg.extra-substituters);
          trusted-public-keys =
            [ cfg.default-substituter.key ]
              ++
              (mapAttrsToList (name: value: value.key) cfg.extra-substituters);
        };

        gc = {
          automatic = true;
          dates = "weekly";
          options = "--delete-older-than 7d";
        };
      };
  };
}
