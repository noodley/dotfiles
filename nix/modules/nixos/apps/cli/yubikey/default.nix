{ options, config, lib, pkgs, ... }:

with lib;
with lib.mynix;
let
  cfg = config.mynix.apps.cli.yubikey;
in
{
  options.mynix.apps.cli.yubikey = with types; {
    enable = mkBoolOpt false "Whether or not to enable Yubikey.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [ yubikey-manager ];
  };
}
