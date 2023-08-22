{ options, config, lib, pkgs, ... }:

with lib;
with lib.mynix;
let
  cfg = config.mynix.suites.desktop;
in
{
  options.mynix.suites.desktop = with types; {
    enable =
      mkBoolOpt false "Whether or not to enable common desktop configuration.";
  };

  config = mkIf cfg.enable {
    mynix = {
      desktop = {
        sway = enabled;
      };

      # TODO: Add firefox and logseq modules
      apps = {
        firefox = enabled;
        logseq = enabled;
      };
    };
  };
}
