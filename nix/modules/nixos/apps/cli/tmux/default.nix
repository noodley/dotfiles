{ options, config, lib, pkgs, ... }:

with lib;
with lib.mynix;
let

  cfg = config.mynix.apps.cli.tmux;

  plugins = (with pkgs.tmuxPlugins; [
      #continuum
      #nord
      #tilish
      #tmux-fzf
      #vim-tmux-navigator
    ]);
in
{
  options.mynix.apps.cli.tmux = with types; {
    enable = mkBoolOpt false "Whether or not to enable tmux.";
  };

  config = mkIf cfg.enable {
    mynix.home.extraOptions = {
      programs.tmux = {
        enable = true;
        clock24 = true;
        historyLimit = 20000;
        keyMode = "vi";
        newSession = true;

        inherit plugins;
      };
    };
  };
}
