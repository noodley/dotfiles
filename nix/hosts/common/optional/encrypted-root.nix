{ config, ... }:
let hostname = config.networking.hostName;
in {
  boot.initrd = {
    luks.devices.enc.device = "/dev/disk/by-label/LUKS";
  };
}
