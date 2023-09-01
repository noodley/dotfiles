{ options, config, lib, pkgs, ... }:

with lib;
with lib.mynix;
let cfg = config.mynix.desktop.addons.swappy;
in
{
  options.mynix.desktop.addons.swappy = with types; {
    enable =
      mkBoolOpt false "Enable Swappy in the desktop environment.";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      swappy
    ];

    xdg.configFile."swappy/config" = {
      enable = true;
      source = ./config;
    };

    home.file."Pictures/screenshots/.keep".text = "";
  };
}
