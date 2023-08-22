{ options, config, pkgs, lib, ... }:

with lib;
with lib.mynix;
let cfg = config.mynix.system.zram-swap;
in
{
  options.mynix.system.zram-swap = with types; {
    enable = mkBoolOpt false "Whether or not to enable zram swap.";
  };

  config = mkIf cfg.enable {
    zramSwap.enable = true;
  };
}
