{ lib, config, pkgs, ... }:

let
  inherit (lib) types mkEnableOption mkIf;
  cfg = config.mynix.desktop.addons.cliphist;
in
{
  options.mynix.desktop.addons.cliphist = {
    enable = mkEnableOption "enable and configure cliphist";
  };

  config = mkIf cfg.enable {
    home.packages = [
      pkgs.cliphist
    ];
  };
}
