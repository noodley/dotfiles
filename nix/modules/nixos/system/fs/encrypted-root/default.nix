{ options, config, pkgs, lib, ... }:

let 
  cfg = config.mynix.system.fs.encrypted-root;

  inherit (lib) mkEnableOption mkIf mkDefault;
  inherit (lib.mynix) mkOpt enabled;
  inherit (lib.types) str;
in
{
  options.mynix.system.fs.encrypted-root = {
    enable = mkEnableOption "Encrypted root device";
    device_label = mkOpt (str) "LUKS" "Encrypted device label.";
  };

  config = mkIf cfg.enable {
    boot.initrd = {
      luks.devices.enc.device = "/dev/disk/by-label/${cfg.device_label}";
    };
  };
}
