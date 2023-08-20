{ pkgs, ... }:
{
  imports = [ ];

  home.packages = with pkgs; [
    logseq
  ];
}
