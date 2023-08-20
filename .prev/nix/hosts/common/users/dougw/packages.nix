{ pkgs, ... }:
{
  # Use home manager for user packages
  users.users.dougw.packages = with pkgs; [ ];
}
