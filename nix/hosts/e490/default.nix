{ pkgs, inputs, lib, ... }: {
  imports = [
    ./hardware-configuration.nix
    ../common/global
    ../common/users/dougw
    ../common/optional/kbd-interception.nix
    ../common/optional/pipewire.nix
  ];

  system.stateVersion = "23.05";
  networking = {
    hostName = "e490";
    networkmanager.enable = true;
  };

  console.font = lib.mkDefault "${pkgs.terminus_font}/share/consolefonts/ter-128b.psf.gz";

  #powerManagement.powertop.enable = true;
  #programs = {
  #  light.enable = true;
  #  adb.enable = true;
  #  dconf.enable = true;
  #  kdeconnect.enable = true;
  #};

  # Lid settings
  #services.logind = {
  #  lidSwitch = "suspend";
  #  lidSwitchExternalPower = "lock";
  #};

  #xdg.portal = {
  #  enable = true;
  #  wlr.enable = true;
  #};
  #hardware = {
  #  opengl = {
  #    enable = true;
  #    extraPackages = with pkgs; [ amdvlk ];
  #    driSupport = true;
  #    driSupport32Bit = true;
  #  };
  #};

}
