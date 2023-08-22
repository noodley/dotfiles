{ config, lib, pkgs, inputs, ... }:

# This file contains an ephemeral btrfs root configuration
let
  cfg = config.mynix.system.fs.root-config-persistence;

  inherit (lib) mkEnableOption mkIf mkDefault;
  inherit (lib.mynix) mkOpt enabled;
  inherit (lib.types) listOf str;

  persistent_directory = "/persist/root";
in
{
  imports = [ inputs.impermanence.nixosModules.impermanence ];

  options.mynix.system.fs.root-config-persistence = {
    enable = mkEnableOption "Persist common system configurations.";
  };

  # The host must be using a btrfs filesystem layout
  config = mkIf cfg.enable {
    environment.persistence = {
      "${persistent_directory}" = {
        directories = [
          "/etc/NetworkManager"
	];
        files = [
          "/etc/machine-id"
          "/etc/ssh/ssh_host_ed25519_key"
          "/etc/ssh/ssh_host_ed25519_key.pub"
          "/etc/ssh/ssh_host_rsa_key"
          "/etc/ssh/ssh_host_rsa_key.pub"
          "/root/.bash_history"
        ];
      };
    };
    programs.fuse.userAllowOther = true;

    # This prevents users being lectured after every wipe on boot. 
    security.sudo.extraConfig = ''
      Defaults lecture = never
    '';
    system.activationScripts.persistent-dirs.text =
      let
        mkHomePersist = user: lib.optionalString user.createHome ''
          mkdir -p /persist/root/${user.home}
          chown ${user.name}:${user.group} /persist/root/${user.home}
          chmod ${user.homeMode} /persist/root/${user.home}
        '';
        users = lib.attrValues config.users.users;
      in
      lib.concatLines (map mkHomePersist users);
  };
}
