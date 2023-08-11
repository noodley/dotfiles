# This file contains an ephemeral btrfs root configuration
# TODO: perhaps partition using disko in the future
{ lib, config, pkgs, ... }:
let
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
  boot.initrd = {
    supportedFilesystems = [ "btrfs" ];
    postDeviceCommands = lib.mkIf (!phase1Systemd) (lib.mkBefore wipeScript);
    systemd.services.restore-root = lib.mkIf phase1Systemd {
      description = "Rollback btrfs rootfs";
      wantedBy = [ "initrd.target" ];
      requires = [
        "dev-disk-by\\x2dlabel-ROOT.device"
      ];
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

  fileSystems = {
    "/" = {
      device = "/dev/disk/by-label/ROOT";
      fsType = "btrfs";
      options = [ "subvol=/root" "compress=zstd" "noatime" ];
    };

    "/nix" = {
      device = "/dev/disk/by-label/ROOT";
      fsType = "btrfs";
      options = [ "subvol=/nix" "compress=zstd" "noatime" ];
    };

    "/persist" = {
      device = "/dev/disk/by-label/ROOT";
      fsType = "btrfs";
      options = [ "subvol=/persist" "compress=zstd" "noatime" ];
      neededForBoot = true;
    };
    "/var/log" = { 
      device = "/dev/disk/by-label/ROOT";
      fsType = "btrfs";
      options = [ "subvol=/log" "compress=zstd" "noatime" ];
      neededForBoot = true;
    };
  };

  # Include a script to show the changes between / and the empty
  # snapshot
  environment.systemPackages = with pkgs; [
    btrfs-root-diff
  ];
}
