{ options, config, pkgs, lib, ... }:

with lib;
with lib.mynix;
let
  cfg = config.mynix.tools.git;
  gpg = config.mynix.security.gpg;
  user = config.mynix.user;
in
{
  options.mynix.tools.git = with types; {
    enable = mkBoolOpt false "Whether or not to install and configure git.";
    userName = mkOpt types.str user.fullName "The name to configure git with.";
    userEmail = mkOpt types.str user.email "The email to configure git with.";
    signingKey = mkOpt types.str user.signingKey "The key ID to sign commits with.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [ git ];

    mynix.home.extraOptions = {
      programs.git = {
        enable = true;
        inherit (cfg) userName userEmail;
        #lfs = enabled;
        signing = {
          key = cfg.signingKey;
          signByDefault = mkIf gpg.enable true;
        };
        extraConfig = {
          init = { defaultBranch = "main"; };
          pull = { rebase = true; };
          push = { autoSetupRemote = true; };
          core = { 
	    whitespace = "trailing-space,space-before-tab"; 
	    editor = "nvim";
	  };
        };
      };
    };
  };
}
