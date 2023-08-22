{ options, config, lib, pkgs, ... }:

with lib;
with lib.mynix;
let 
  cfg = config.mynix.hardware.kbd-interception;
in
{
  options.mynix.hardware.kbd-interception = with types; {
    enable = mkBoolOpt false "Whether or not to enable common utilities.";
  };

  config = mkIf cfg.enable {
    services.interception-tools = {
      enable = true;
      plugins = [ 
        pkgs.interception-tools-plugins.caps2esc 
        pkgs.mynix.space2meta
      ];
      
      udevmonConfig = ''
        - JOB: "${pkgs.interception-tools}/bin/intercept -g $DEVNODE | ${pkgs.interception-tools-plugins.caps2esc}/bin/caps2esc -m 1 | ${pkgs.mynix.space2meta}/bin/space2meta | ${pkgs.interception-tools}/bin/uinput -d $DEVNODE"
          DEVICE:
            EVENTS:
              EV_KEY: [KEY_CAPSLOCK, KEY_ESC, KEY_SPACE] 
      ''; 
    };
  };
}
