{ options, config, pkgs, lib, inputs, ... }:

with lib;
with lib.mynix;
let
  cfg = config.mynix.security.gpg;

  reload-yubikey = pkgs.writeShellScriptBin "reload-yubikey" ''
    ${pkgs.gnupg}/bin/gpg-connect-agent "scd serialno" "learn --force" /bye
  '';
in
{
  options.mynix.security.gpg = with types; {
    enable = mkBoolOpt false "Whether or not to enable GPG.";
    agentTimeout = mkOpt int 5 "The amount of time to wait before continuing with shell init.";
  };

  config = mkIf cfg.enable {
    services.pcscd.enable = true;
    services.udev.packages = with pkgs; [ yubikey-personalization ];

#    environment.shellInit = ''
#      gpg-connect-agent /bye
#      export SSH_AUTH_SOCK=$(${pkgs.gnupg}/bin/gpgconf --list-dirs agent-ssh-socket)
#    '';

    environment.systemPackages = with pkgs; [
      gnupg
      pinentry-curses
      cryptsetup
      paperkey
      reload-yubikey
    ];

    programs = {
      ssh.startAgent = false;

      gnupg.agent = {
        enable = true;
        enableSSHSupport = true;
        enableExtraSocket = true;
        pinentryFlavor = "curses";
      };
    };
  };
}
