{ options, config, lib, pkgs, ... }:

with lib;
with lib.mynix;
let
  cfg = config.mynix.tools.bottom;
in
{
  options.mynix.tools.bottom = with types; {
    enable = mkBoolOpt false "Whether or not to enable Bottom.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      bottom
    ];
  };
}
