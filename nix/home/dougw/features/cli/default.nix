{ pkgs, ... }: {
  imports = [
    ./bash.nix
    ./git.nix
    ./nix-index.nix
    ./ssh.nix
    ./tmux.nix
  ];
  home.packages = with pkgs; [
    bc # Calculator
    bottom # System viewer
    jq # JSON pretty printer and manipulator
  ];
}
