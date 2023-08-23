{ options, config, lib, pkgs, ... }:

with lib;
with lib.mynix;
let
  cfg = config.mynix.suites.sway;
in
{
  options.mynix.suites.sway = with types; {
    enable =
      mkBoolOpt false "Whether or not to enable sway applications.";
  };

  config = mkIf cfg.enable {
    mynix = {
      desktop = {
        addons.swayidle = enabled;
        addons.swaylock = enabled;
      };
    };
  };
}
