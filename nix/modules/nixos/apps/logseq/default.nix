{ options, config, lib, pkgs, ... }:

with lib;
with lib.mynix;
let cfg = config.mynix.apps.logseq;
in
{
  options.mynix.apps.logseq = with types; {
    enable = mkBoolOpt false "Whether or not to enable logseq.";
  };

  config =
    mkIf cfg.enable { environment.systemPackages = with pkgs; [ logseq ]; };
}
