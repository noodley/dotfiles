# This file (and the global directory) holds config that i use on all hosts
{ inputs, outputs, pkgs, ... }: {
  imports = [
    inputs.home-manager.nixosModules.home-manager
    #./acme.nix
    #./auto-upgrade.nix
    #./fish.nix
    ./locale.nix
    ./nix.nix
    #./openssh.nix
    ./optin-persistence.nix
    #./podman.nix
    #./sops.nix
    #./ssh-serve-store.nix
    #./steam-hardware.nix
    ./systemd-initrd.nix
    #./tailscale.nix
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
    neovim
    git
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
