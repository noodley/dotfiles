{ lib, config, pkgs, ... }:

let
  inherit (lib) types mkEnableOption mkIf;
  cfg = config.mynix.desktop.addons.swayidle;
  lock_cmd = "${pkgs.swaylock}/bin/swaylock";
in
{
  options.mynix.desktop.addons.swayidle = {
    enable = mkEnableOption "enable swayidle";
  };

  config = mkIf cfg.enable {
    services.swayidle = {
      enable = true;
      events = [ 
        { event = "before-sleep"; command = lock_cmd; }  
      ];
      timeouts = [
        { timeout = 600; command = lock_cmd; }
      ];
    };

    home.packages = [
      pkgs.swayidle
    ];
  };
}
