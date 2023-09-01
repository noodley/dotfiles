{ options, config, lib, pkgs, ... }:

with lib;
with lib.mynix;
let
  cfg = config.mynix.suites.desktop;
in
{
  options.mynix.suites.desktop = with types; {
    enable =
      mkBoolOpt false "Enable wayland and host level desktop settings.";
  };

  config = mkIf cfg.enable {
    mynix = {
      desktop = { };

      apps = {
        firefox = enabled;
        logseq = enabled;
      };
    };

    xdg.portal = {
      enable = true;
      extraPortals=[
      	pkgs.xdg-desktop-portal-wlr
      	pkgs.xdg-desktop-portal-gtk
      ];
    };

    # This is needed because the home manager version of swaylock
    # does not create the pam file.
    security.pam.services.swaylock = {};

    programs = {
      dconf.enable = true;
    };
  };
}
