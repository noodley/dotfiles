{ pkgs, lib, config, ... }:
let
  ssh = "${pkgs.openssh}/bin/ssh";
in
{
  home.packages = [ ];
  programs.git = {
    enable = true;
    aliases = { };
    userName = "Doug Weimer";
    userEmail = "dweimer@gmail.com";
    extraConfig = { 
      core.editor = "nvim";
    };
    #lfs.enable = true;
    ignores = [ ".direnv" "result" ];
  };
}
