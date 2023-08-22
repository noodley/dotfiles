{ options, config, lib, pkgs, ... }:

with lib;
with lib.mynix;
let cfg = config.mynix.desktop.addons.wofi;
in
{
  options.mynix.desktop.addons.wofi = with types; {
    enable =
      mkBoolOpt false "Whether to enable the Wofi in the desktop environment.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [ wofi wofi-emoji ];

    # config -> .config/wofi/config
    # css -> .config/wofi/style.css
    # colors -> $XDG_CACHE_HOME/wal/colors
    # mynix.home.configFile."foot/foot.ini".source = ./foot.ini;
    mynix.home.configFile."wofi/config".source = ./config;
    mynix.home.configFile."wofi/style.css".source = ./style.css;
  };
}
