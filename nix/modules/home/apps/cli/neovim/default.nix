inputs@{ options, config, lib, pkgs, ... }:

with lib;
with lib.mynix;
let
  cfg = config.mynix.apps.cli.neovim;
in
{
  options.mynix.apps.cli.neovim = with types; {
    enable = mkBoolOpt false "Enable neovim configuration.";
  };

  config = mkIf cfg.enable {
    programs.neovim = {
      enable = true;
      defaultEditor = true;
      viAlias = true;
      vimAlias = true;
      vimdiffAlias = true;
      plugins = with pkgs.vimPlugins; [
        fzf-lua
      ];
      extraConfig = ''
        nnoremap <c-P> <cmd>lua require('fzf-lua').files()<CR>
      '';
    };
  };
}
