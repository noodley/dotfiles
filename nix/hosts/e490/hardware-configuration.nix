{
  imports = [
    ../common/optional/ephemeral-btrfs.nix
    ../common/optional/encrypted-root.nix
    ../common/optional/zram-swap.nix
  ];

  boot = {
    initrd = {
      availableKernelModules = [ "xhci_pci" "ahci" "usb_storage" "sd_mod" "sdhci_pci" ];
      kernelModules = [ ];
    };
    kernelModules = [ "kvm-intel" ];
    extraModulePackages = [ ];
    loader = {
      systemd-boot = {
        enable = true;
        #consoleMode = "max";
      };
      efi.canTouchEfiVariables = true;
    };
  };

  fileSystems = {
    "/boot" = {
      device = "/dev/disk/by-label/BOOT";
      fsType = "vfat";
    };
  };

  swapDevices = [ ];

  nixpkgs.hostPlatform.system = "x86_64-linux";
  hardware.cpu.amd.updateMicrocode = true;
  powerManagement.cpuFreqGovernor = "powersave";
}
