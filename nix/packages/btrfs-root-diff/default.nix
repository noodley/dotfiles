{ pkgs, lib, ... }:

pkgs.writeShellScriptBin "btrfs-root-diff" 
  (builtins.readFile ./btrfs-root-diff.sh)
