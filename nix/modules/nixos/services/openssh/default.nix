{ options, config, pkgs, lib, host ? "", format ? "", inputs ? { }, ... }:

with lib;
with lib.mynix;
let
  cfg = config.mynix.services.openssh;

in
{
  options.mynix.services.openssh = with types; {
    enable = mkBoolOpt false "Whether or not to configure OpenSSH support.";
    authorizedKeys =
      mkOpt (listOf str) [ default-key ] "The public keys to apply.";
    port = mkOpt port 5309 "The port to listen on.";
    manage-other-hosts = mkOpt bool true "Whether or not to add other host configurations to SSH config.";
  };

  config = mkIf cfg.enable {
    services.openssh = {
      enable = true;

      settings = {
        PermitRootLogin = if format == "install-iso" then "yes" else "no";
        PasswordAuthentication = true;
	PermitEmptyPasswords = "no";
        # Automatically remove stale sockets
        StreamLocalBindUnlink = "yes";
      };

      #extraConfig = '' '';

      ports = [
	cfg.port
      ];
    };
  };
}
