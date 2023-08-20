# This file defines the "non-hardware dependent" part of opt-in persistence
# It imports impermanence, defines the basic persisted dirs, and ensures each
# users' home persist dir exists and has the right permissions
#
# It works even if / is tmpfs, btrfs snapshot, or even not ephemeral at all.
{ lib, inputs, config, ... }: {
  imports = [
    inputs.impermanence.nixosModules.impermanence
  ];

  environment.persistence = {
    "/persist/root" = {
      directories = [
        "/etc/NetworkManager"
#        "/var/lib/systemd"
#        "/var/lib/nixos"
#        "/var/log"
#        "/srv"
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
}
