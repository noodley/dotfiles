inputs@{ options, config, lib, pkgs, ... }:

with lib;
with lib.mynix;
let
  cfg = config.mynix.apps.cli.fzf;
in
{
  options.mynix.apps.cli.fzf = with types; {
    enable = mkBoolOpt false "Enable fzf configuration.";
  };

  config = mkIf cfg.enable {
    programs.fzf = {
      enable = true;
      defaultCommand = "fd --type f";
    };

    # We use fd by default for fzf
    home.packages = [
      # https://github.com/sharkdp/fd
      pkgs.fd
    ];
  };
}
