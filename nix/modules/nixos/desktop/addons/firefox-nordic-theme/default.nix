{ options, config, lib, pkgs, ... }:

with lib;
with lib.mynix;
let
  cfg = config.mynix.desktop.addons.firefox-nordic-theme;
  profileDir = ".mozilla/firefox/${config.mynix.user.name}";
in
{
  options.mynix.desktop.addons.firefox-nordic-theme = with types; {
    enable = mkBoolOpt false "Whether to enable the Nordic theme for firefox.";
  };

  config = mkIf cfg.enable {
    mynix.apps.firefox = {
      extraConfig = builtins.readFile
        "${pkgs.mynix.firefox-nordic-theme}/configuration/user.js";
      userChrome = ''
        @import "${pkgs.mynix.firefox-nordic-theme}/userChrome.css";
      '';
    };
  };
}
