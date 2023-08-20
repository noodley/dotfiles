{ writeShellScriptBin, findutils }:
writeShellScriptBin "btrfs-root-diff" (builtins.readFile ./btrfs-root-diff.sh)
