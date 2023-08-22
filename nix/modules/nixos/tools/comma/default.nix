{ options, config, lib, pkgs, ... }:

with lib;
with lib.mynix;
let
  cfg = config.mynix.tools.comma;
in
{
  options.mynix.tools.comma = with types; {
    enable = mkBoolOpt false "Whether or not to enable comma.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      comma
      mynix.nix-update-index
    ];

    mynix.home = {
      configFile = {
        "wgetrc".text = "";
      };

      extraOptions = {
        programs.nix-index.enable = true;
      };
    };
  };
}
