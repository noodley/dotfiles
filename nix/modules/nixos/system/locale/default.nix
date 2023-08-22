{ options, config, pkgs, lib, ... }:

with lib;
with lib.mynix;
let cfg = config.mynix.system.locale;
in
{
  options.mynix.system.locale = with types; {
    enable = mkBoolOpt false "Whether or not to manage locale settings.";
  };

  config = mkIf cfg.enable {
    i18n = {
      defaultLocale = lib.mkDefault "en_US.UTF-8";
      extraLocaleSettings = { };
      supportedLocales = lib.mkDefault [
        "en_US.UTF-8/UTF-8"
      ];
    };

    console = { keyMap = mkForce "us"; };
  };
}
