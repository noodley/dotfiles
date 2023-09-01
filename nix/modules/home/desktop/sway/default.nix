{ options, config, lib, pkgs, ... }:

with lib;
with lib.mynix;
let
  cfg = config.mynix.desktop.sway;
  substitutedConfig = pkgs.substituteAll {
    src = ./config;
    # TODO, just set foot explicitly.
    #term = term.pkg.pname or term.pkg.name;
  };
in
{
  options.mynix.desktop.sway = with types; {
    enable = mkBoolOpt false "Whether or not to enable Sway.";
    extraConfig =
      mkOpt str "" "Additional configuration for the Sway config file.";
  };

  config = mkIf cfg.enable {
    # Desktop additions
    mynix.desktop.addons = {
      swayidle = enabled;
      swaylock = enabled;
      foot = enabled;
      gtk = enabled;
      mako = enabled;
      fuzzel = enabled;
      swappy = enabled;
      waybar = enabled;

#      xwayland = enabled;
#      wl-clipboard = enabled;
#      wf-recorder = enabled;
#      libinput = enabled;
#      playerctl = enabled;
#      brightnessctl = enabled;
#      sway-contrib.grimshot = enabled;
#      glib = enabled; # for gsettings

    };

    fonts.fontconfig.enable = true;
    home.packages = with pkgs; [ 
      roboto roboto-serif font-awesome
    ];

    wayland.windowManager.sway = {
      enable = true;
      config = {
        modifier = "Mod4";
	menu = "${pkgs.fuzzel}/bin/fuzzel";
	bars = [{
	  "command" = "${pkgs.waybar}/bin/waybar";
	}];
	startup = [ ];
      };
    };
  };
}
