{ options, config, lib, pkgs, ... }:

with lib;
with lib.mynix;
let cfg = config.mynix.desktop.addons.foot;
in
{
  options.mynix.desktop.addons.foot = with types; {
    enable = mkBoolOpt false "Whether to enable the gnome file manager.";
  };

  config = mkIf cfg.enable {
    mynix.desktop.addons.term = {
      enable = true;
      pkg = pkgs.foot;
    };

    mynix.home.configFile."foot/foot.ini".source = ./foot.ini;
  };
}
