# This file (and the global directory) holds config that i use on all hosts
{ inputs, outputs, pkgs, ... }: {
  imports = [
    inputs.home-manager.nixosModules.home-manager
    ./locale.nix
    ./nix.nix
    ./openssh.nix
    ./optin-persistence.nix
    #./sops.nix
    ./systemd-initrd.nix
  ] ++ (builtins.attrValues outputs.nixosModules);

  
  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  home-manager.extraSpecialArgs = { inherit inputs outputs; };

  nixpkgs = {
    overlays = builtins.attrValues outputs.overlays;
    config = {
      allowUnfree = true;
      permittedInsecurePackages = [ ];
    };
  };

  environment.profileRelativeSessionVariables = { };

  environment.enableAllTerminfo = true;

  environment.systemPackages = with pkgs; [
    git
    neovim
    pciutils
    psmisc
    usbutils
  ];

  hardware.enableRedistributableFirmware = true;
  hardware.enableAllFirmware = true;
  # TODO: domain? networking.domain = "m7.rs";

  # Increase open file limit for sudoers
  security.pam.loginLimits = [
    {
      domain = "@wheel";
      item = "nofile";
      type = "soft";
      value = "524288";
    }
    {
      domain = "@wheel";
      item = "nofile";
      type = "hard";
      value = "1048576";
    }
  ];
}
