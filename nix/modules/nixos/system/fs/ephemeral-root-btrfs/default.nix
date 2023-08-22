{ config, lib, pkgs, ... }:

# This file contains an ephemeral btrfs root configuration
let
  cfg = config.mynix.system.fs.ephemeral-root-btrfs;

  inherit (lib) mkEnableOption mkIf mkDefault;
  inherit (lib.mynix) mkOpt enabled;
  inherit (lib.types) listOf str;

  hostname = config.networking.hostName;

  wipeScript = ''
    mkdir -p /mnt
    mount -o subvol=/ /dev/disk/by-label/ROOT /mnt
    btrfs subvolume list -o /mnt/root | cut -f9 -d' ' |
    while read subvolume; do
      echo "deleteing /$subvolume subvolume..."
      btrfs subvolume delete "/mnt/$subvolume"
    done &&
    echo "deleteing /root subvolume..." &&
    btrfs subvolume delete /mnt/root

    echo "Restoring blank root subvolume..."
    btrfs subvolume snapshot /mnt/root-blank /mnt/root

    umount /mnt
  '';

  phase1Systemd = config.boot.initrd.systemd.enable;

in
{
  options.mynix.system.fs.ephemeral-root-btrfs = {
    enable = mkEnableOption "Ephemeral BTRFS Root";
  };

  # The host must be using a btrfs filesystem layout
  config = mkIf cfg.enable {

    mynix.system.fs = {
      btrfs-layout = {
        enable = true;
        device_label = "ROOT";
      };
      root-config-persistence = {
        enable = true;
      };
    };

    boot.initrd = {
      postDeviceCommands = lib.mkIf (!phase1Systemd) (lib.mkBefore wipeScript);
      systemd.services.restore-root = lib.mkIf phase1Systemd {
        description = "Rollback btrfs rootfs";
        wantedBy = [ "initrd.target" ];
        requires = [ "dev-disk-by\\x2dlabel-ROOT.device" ];
        after = [
          "dev-disk-by\\x2dlabel-ROOT.device"
          "systemd-cryptsetup@${hostname}.service"
        ];
        before = [ "sysroot.mount" ];
        unitConfig.DefaultDependencies = "no";
        serviceConfig.Type = "oneshot";
        script = wipeScript;
      };
    };

    # Include a script to show the changes between / and the empty
    # snapshot
    environment.systemPackages = with pkgs.mynix; [
      btrfs-root-diff
    ];
  };

}
