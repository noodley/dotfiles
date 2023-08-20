{ pkgs, lib, config, ... }:
let 
  ssh = "${pkgs.openssh}/bin/ssh";
  signingKey = "6129D14861D5C62E";
in
{
  home.packages = [ ];

  services.gpg-agent = {
      enable = true;
      enableSshSupport = true;
      pinentryFlavor = "qt";
  };

  programs.git = {
    enable = true;
    aliases = { };
    userName = "Doug Weimer";
    userEmail = "dweimer@gmail.com";
    signing.key = signingKey;
    signing.signByDefault = true;
    extraConfig = { 
      core.editor = "nvim";
    };
    #lfs.enable = true;
    ignores = [ ".direnv" "result" ];
  };
}
