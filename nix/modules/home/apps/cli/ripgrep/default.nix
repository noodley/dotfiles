inputs@{ options, config, lib, pkgs, ... }:

with lib;
with lib.mynix;
let
  cfg = config.mynix.apps.cli.ripgrep;
in
{
  options.mynix.apps.cli.ripgrep = with types; {
    enable = mkBoolOpt false "Enable ripgrep configuration.";
  };

  config = mkIf cfg.enable {
    programs.ripgrep = {
      enable = true;
    };
  };
}
