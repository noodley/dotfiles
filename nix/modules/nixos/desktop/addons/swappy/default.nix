{ options, config, lib, pkgs, ... }:

with lib;
with lib.mynix;
let cfg = config.mynix.desktop.addons.swappy;
in
{
  options.mynix.desktop.addons.swappy = with types; {
    enable =
      mkBoolOpt false "Whether to enable Swappy in the desktop environment.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [ swappy ];

    mynix.home.configFile."swappy/config".source = ./config;
    mynix.home.file."Pictures/screenshots/.keep".text = "";
  };
}
