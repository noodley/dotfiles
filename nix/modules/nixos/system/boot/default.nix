{ options, config, pkgs, lib, ... }:

with lib;
with lib.mynix;
let cfg = config.mynix.system.boot;
in
{
  options.mynix.system.boot = with types; {
    enable = mkBoolOpt false "Whether or not to enable booting.";
    systemd-initrd = mkBoolOpt true "Enable systemd initrd.";
  };

  config = mkIf cfg.enable {
    boot.loader.efi.canTouchEfiVariables = true;
    boot.loader.systemd-boot.enable = true;
    boot.initrd.systemd.enable = cfg.systemd-initrd;
  };
}
