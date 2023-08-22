{ options, config, lib, pkgs, ... }:

with lib;
with lib.mynix;
let cfg = config.mynix.desktop.addons.term;
in
{
  options.mynix.desktop.addons.term = with types; {
    enable = mkBoolOpt false "Whether to enable the gnome file manager.";
    pkg = mkOpt package pkgs.foot "The terminal to install.";
  };

  config = mkIf cfg.enable { environment.systemPackages = [ cfg.pkg ]; };
}
