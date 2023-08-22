{ options, config, pkgs, lib, ... }:

with lib;
with lib.mynix;
let
  cfg = config.mynix.user;
in
{
  options.mynix.user = with types; {
    name = mkOpt str "dougw" "The name to use for the user account.";
    fullName = mkOpt str "Doug Weimer" "The full name of the user.";
    email = mkOpt str "dweimer@gmail.com" "The email of the user.";
    signingKey = mkOpt str "6129D14861D5C62E" "The users gpg signing key.";
    initialPassword = mkOpt str "password"
      "The initial password to use when the user is first created.";
    extraGroups = mkOpt (listOf str) [ "wheel" ] "Groups for the user to be assigned.";
    extraOptions = mkOpt attrs { }
      (mdDoc "Extra options passed to `users.users.<name>`.");
  };

  config = {
    environment.systemPackages = with pkgs; [ ];

    users.users.${cfg.name} = {
      isNormalUser = true;

      inherit (cfg) name initialPassword;

      home = "/home/${cfg.name}";
      group = "users";

      shell = pkgs.bash;

      # Arbitrary user ID to use for the user. Since I only
      # have a single user on my machines this won't ever collide.
      # However, if you add multiple users you'll need to change this
      # so each user has their own unique uid (or leave it out for the
      # system to select).
      uid = 1000;

      passwordFile = "/persist/secrets/${cfg.name}-pw";

      extraGroups = [ ] ++ cfg.extraGroups;
    } // cfg.extraOptions;
  };
}
