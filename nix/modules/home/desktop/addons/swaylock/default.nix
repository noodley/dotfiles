{ lib, config, pkgs, ... }:

let
  inherit (lib) types mkEnableOption mkIf;
  cfg = config.mynix.desktop.addons.swaylock;
in
{
  options.mynix.desktop.addons.swaylock = {
    enable = mkEnableOption "enable and configure swaylock";
  };

  config = mkIf cfg.enable {
    programs.swaylock = {
      enable = true;
      settings = {
        image = "${pkgs.mynix.wallpapers.cat-lock}";
        color = "808080";
        font-size = 24;
        indicator-idle-visible = false;
        indicator-radius = 100;
        line-color = "ffffff";
        show-failed-attempts = true;
      };
    };
  };
}
