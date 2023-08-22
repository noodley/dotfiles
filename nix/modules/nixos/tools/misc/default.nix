{ options, config, lib, pkgs, ... }:

with lib;
with lib.mynix;
let cfg = config.mynix.tools.misc;
in
{
  options.mynix.tools.misc = with types; {
    enable = mkBoolOpt false "Whether or not to enable common utilities.";
  };

  config = mkIf cfg.enable {
    mynix.home.configFile."wgetrc".text = "";

    environment.systemPackages = with pkgs; [
      file
      fzf
      killall
      jq
      pciutils
      psmisc
      unzip
      usbutils
      wget
    ];
  };
}
