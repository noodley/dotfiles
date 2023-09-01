{ options, config, lib, pkgs, ... }:

with lib;
with lib.mynix;
let cfg = config.mynix.desktop.addons.mako;
in
{
  options.mynix.desktop.addons.mako = with types; {
    enable = mkBoolOpt false "Whether to enable the Mako service.";
  };

  config = mkIf cfg.enable {
    services.mako = {
      enable = true;
      font = "Hack Nerd Font Mono 10";
      textColor = "#2e3440ff";
      backgroundColor = "#eceff4f4";
      borderColor = "#d8dee9ff";
      borderRadius = 8;
      borderSize = 0;
      margin = "12,12,6";
      padding = "12";
      defaultTimeout = 5000;
    };
  };
}
