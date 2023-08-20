{ pkgs, inputs, lib, ... }: {
  imports = [
    ./hardware-configuration.nix
    ../common/global
    ../common/users/dougw
    ../common/optional/intel-graphics.nix
    ../common/optional/kbd-interception.nix
    ../common/optional/pipewire.nix
    ../common/optional/polkit.nix
    inputs.hardware.nixosModules.common-pc-ssd
    inputs.hardware.nixosModules.common-cpu-intel
  ];

  system.stateVersion = "23.05";
  networking = {
    hostName = "e490";
    networkmanager.enable = true;
  };

  console.font = lib.mkDefault "${pkgs.terminus_font}/share/consolefonts/ter-128b.psf.gz";

  programs = {
  #  light.enable = true;
    dconf.enable = true;
  };

  # Lid settings
  #services.logind = {
  #  lidSwitch = "suspend";
  #  lidSwitchExternalPower = "lock";
  #};

  xdg.portal = {
    enable = true;
    extraPortals=[
    	pkgs.xdg-desktop-portal-wlr
    	pkgs.xdg-desktop-portal-gtk
    ];
  };

  hardware = {
    opengl = {
      enable = true;
    };
  };
}
