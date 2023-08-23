{ options, config, lib, pkgs, ... }:

with lib;
with lib.mynix;
let
  cfg = config.mynix.suites.common;
in
{
  options.mynix.suites.common = with types; {
    enable = mkBoolOpt false "Enable common user configuration.";
  };

  config = mkIf cfg.enable {
    mynix = {
      apps.cli = {
	neovim = enabled;
	fzf = enabled;
      };
    };
  };
}
