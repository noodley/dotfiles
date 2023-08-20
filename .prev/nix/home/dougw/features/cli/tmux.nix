{ pkgs, lib, config, ... }:
{
  home.packages = [ ];
  programs.tmux = {
    enable = true;
    keyMode = "vi";
  };
}
