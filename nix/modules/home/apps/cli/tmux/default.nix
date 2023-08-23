inputs@{ options, config, lib, pkgs, ... }:

with lib;
with lib.mynix;
let
  cfg = config.mynix.apps.cli.tmux;
in
{
  options.mynix.apps.cli.tmux = with types; {
    enable = mkBoolOpt false "Enable tmux configuration.";
  };

  config = mkIf cfg.enable {
    programs.tmux = {
      enable = true;
      clock24 = true;
      historyLimit = 20000;
      keyMode = "vi";
      newSession = true;
      plugins = with pkgs.tmuxPlugins; [
        tmux-thumbs
      ];
    };
  };
}
