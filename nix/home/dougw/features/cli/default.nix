{ pkgs, ... }: {
  imports = [
    ./bash.nix
    ./direnv.nix
    ./git.nix
    ./ssh.nix
    ./tmux.nix
  ];
  home.packages = with pkgs; [
    bc # Calculator
    bottom # System viewer
    jq # JSON pretty printer and manipulator
  ];
}
