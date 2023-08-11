{ pkgs, ... }: {
  imports = [
    ./bash.nix
    ./git.nix
    ./tmux.nix
#    ./bat.nix
#    ./direnv.nix
#    ./fish.nix
#    ./gh.nix
#    ./gpg.nix
#    ./jujutsu.nix
#    ./nix-index.nix
#    ./pfetch.nix
#    ./ranger.nix
#    ./screen.nix
#    ./shellcolor.nix
#    ./ssh.nix
#    ./starship.nix
#    ./xpo.nix
  ];
  home.packages = with pkgs; [
    #comma # Install and run programs by sticking a , before them
    #distrobox # Nice escape hatch, integrates docker images with my environment

    bc # Calculator
    bottom # System viewer
    jq # JSON pretty printer and manipulator

    #ncdu # TUI disk usage
    #exa # Better ls
    #ripgrep # Better grep
    #fd # Better find
    #httpie # Better curl
    #diffsitter # Better diff
    #trekscii # Cute startrek cli printer
    #timer # To help with my ADHD paralysis

    #nil # Nix LSP
    #nixfmt # Nix formatter
    #nix-inspect # See which pkgs are in your PATH

    #ltex-ls # Spell checking LSP
  ];
}
