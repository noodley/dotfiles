{ options, config, lib, pkgs, ... }:

with lib;
with lib.mynix;
let
  cfg = config.mynix.desktop.addons.gtk;
  #gdmCfg = config.services.xserver.displayManager.gdm;
in
{
  options.mynix.desktop.addons.gtk = with types; {
    enable = mkBoolOpt false "Whether to customize GTK and apply themes.";
    theme = {
      name = mkOpt str "Nordic-darker"
        "The name of the GTK theme to apply.";
      pkg = mkOpt package pkgs.nordic "The package to use for the theme.";
    };
    cursor = {
      name = mkOpt str "Bibata-Modern-Ice"
        "The name of the cursor theme to apply.";
      pkg = mkOpt package pkgs.bibata-cursors "The package to use for the cursor theme.";
    };
    icon = {
      name = mkOpt str "Papirus"
        "The name of the icon theme to apply.";
      pkg = mkOpt package pkgs.papirus-icon-theme "The package to use for the icon theme.";
    };
  };

  config = mkIf cfg.enable {
#    environment.sessionVariables = {
#      XCURSOR_THEME = cfg.cursor.name;
#    };

    gtk = {
       enable = true;

       theme = {
         name = cfg.theme.name;
         package = cfg.theme.pkg;
       };

       cursorTheme = {
         name = cfg.cursor.name;
         package = cfg.cursor.pkg;
       };

       iconTheme = {
         name = cfg.icon.name;
         package = cfg.icon.pkg;
       };
     };

    #dconf.settings = mkIf gdmCfg.enable {
    #  "org/gnome/settings-daemon/plugins/power" = {
    #    sleep-inactive-ac-type = "nothing";
    #    sleep-inactive-battery-type = "nothing";
    #    sleep-inactive-ac-timeout = 0;
    #    sleep-inactive-battery-timeout = 0;
    #  };
    #  "org/gnome/desktop/interface" = {
    #    gtk-theme = "${cfg.theme.name}";
    #    cursor-theme = "${cfg.cursor.name}";
    #    icon-theme = "${cfg.icon.name}";
    #  };
    #};
  };
}
