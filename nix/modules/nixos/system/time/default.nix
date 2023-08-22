{ options, config, pkgs, lib, ... }:

with lib;
with lib.mynix;
let cfg = config.mynix.system.time;
in
{
  options.mynix.system.time = with types; {
    enable =
      mkBoolOpt false "Whether or not to configure timezone information.";
  };

  # systemd-timesyncd is enabled by default in nixos
  config = mkIf cfg.enable { time.timeZone = "America/Los_Angeles"; };
}
