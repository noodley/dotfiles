{ options, config, lib, pkgs, ... }:

with lib;
with lib.mynix;
let cfg = config.mynix.desktop.addons.fuzzel;
in
{
  options.mynix.desktop.addons.fuzzel = with types; {
    enable = mkBoolOpt false "Enable the Fuzzel application launcher.";
  };

  config = mkIf cfg.enable {
    programs.fuzzel = {
      enable = true;
      settings = {
        main = {
	  terminal = "${pkgs.foot}/bin/foot";
	  layer = "overlay";
	};
	colors.background = "4C7899dd";
	colors.text = "ffffffff";
      };
    };
  };
}
