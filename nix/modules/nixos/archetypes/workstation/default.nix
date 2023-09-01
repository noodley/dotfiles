{ options, config, lib, pkgs, ... }:
with lib;
with lib.mynix;
let cfg = config.mynix.archetypes.workstation;
in
{
  options.mynix.archetypes.workstation = with types; {
    enable =
      mkBoolOpt false "Whether or not to enable the workstation archetype.";
  };

  config = mkIf cfg.enable {
    mynix = {
      suites = {
        common = enabled;
        development = enabled;
        desktop = enabled;
      };
    };
  };
}
