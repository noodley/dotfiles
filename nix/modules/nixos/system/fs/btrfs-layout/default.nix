{ config, lib, ... }:

# Standard BTRFS filesystem layout
let
  cfg = config.mynix.system.fs.btrfs-layout;

  inherit (lib) mkEnableOption mkIf mkDefault;
  inherit (lib.mynix) mkOpt enabled;
  inherit (lib.types) str;
in
{
  options.mynix.system.fs.btrfs-layout = {
    enable = mkEnableOption "BTRFS Filesystem layout";
    device_label = mkOpt (str) "ROOT" "Root device label.";
  };

  # The host must be using a btrfs filesystem layout
  config = mkIf cfg.enable {

    boot.initrd.supportedFilesystems = [ "btrfs" ];

    fileSystems = {
      "/" = {
        device = "/dev/disk/by-label/${cfg.device_label}";
        fsType = "btrfs";
        options = [ "subvol=/root" "compress=zstd" "noatime" ];
      };

      "/nix" = {
        device = "/dev/disk/by-label/${cfg.device_label}";
        fsType = "btrfs";
        options = [ "subvol=/nix" "compress=zstd" "noatime" ];
      };

      "/persist" = {
        device = "/dev/disk/by-label/${cfg.device_label}";
        fsType = "btrfs";
        options = [ "subvol=/persist" "compress=zstd" "noatime" ];
        neededForBoot = true;
      };
      "/home" = {
        device = "/dev/disk/by-label/${cfg.device_label}";
        fsType = "btrfs";
        options = [ "subvol=/home" "compress=zstd" "noatime" ];
        neededForBoot = true;
      };
      "/var/log" = { 
        device = "/dev/disk/by-label/${cfg.device_label}";
        fsType = "btrfs";
        options = [ "subvol=/log" "compress=zstd" "noatime" ];
        neededForBoot = true;
      };
    };
  };

}
