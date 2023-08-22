{ options, config, lib, pkgs, ... }:

with lib;
with lib.mynix;
let cfg = config.mynix.desktop.addons.waybar;
in
{
  options.mynix.desktop.addons.waybar = with types; {
    enable =
      mkBoolOpt false "Whether to enable Waybar in the desktop environment.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [ waybar ];

    mynix.home.configFile."waybar/config".source = ./config;
    mynix.home.configFile."waybar/style.css".source = ./style.css;
  };
}
