{ options, config, lib, pkgs, ... }:

with lib;
with lib.mynix;
let
  cfg = config.mynix.suites.common;
in
{
  options.mynix.suites.common = with types; {
    enable = mkBoolOpt false "Whether or not to enable common configuration.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = [ ];

    mynix = {
      nix = enabled;

      apps.cli = {
	neovim = enabled;
	yubikey = enabled;
      };

      system = {
        boot = enabled;
	zram-swap = enabled;
        locale = enabled;
        time = enabled;
        fonts = enabled;
      };

      tools = {
        misc = enabled;
        comma = enabled;
        bottom = enabled;
      };

      hardware = {
        audio = enabled;
        networking = enabled;
	kbd-interception = enabled;
      };

      services = {
        openssh = enabled;
      };

      security = {
        gpg = enabled;
	polkit = enabled;
      };
    };
  };
}
