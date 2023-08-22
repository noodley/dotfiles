inputs@{ options, config, lib, pkgs, ... }:

with lib;
with lib.mynix;
let
  cfg = config.mynix.apps.cli.neovim;
in
{
  options.mynix.apps.cli.neovim = with types; {
    enable = mkBoolOpt false "Whether or not to enable neovim.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      neovim
    ];

    environment.variables = {
      PAGER = "less";
      MANPAGER = "less";
      EDITOR = "nvim";
    };

    mynix.home = {
      extraOptions = {
        # Use Neovim for Git diffs.
        programs.zsh.shellAliases.vimdiff = "nvim -d";
        programs.bash.shellAliases.vimdiff = "nvim -d";
        programs.fish.shellAliases.vimdiff = "nvim -d";
	programs.bash.shellAliases.vi = "nvim";
	programs.bash.shellAliases.vim = "nvim";
      };
    };
  };
}
