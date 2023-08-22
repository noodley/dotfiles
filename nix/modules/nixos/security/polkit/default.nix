{ options, config, pkgs, lib, inputs, ... }:

with lib;
with lib.mynix;
let
  cfg = config.mynix.security.polkit;
in
{
  options.mynix.security.polkit = with types; {
    enable = mkBoolOpt false "Whether or not to enable polkit.";
  };

  config = mkIf cfg.enable {
    security.polkit.enable = true;
  };
}
