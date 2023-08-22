{ options, config, pkgs, lib, inputs, ... }:

with lib;
with lib.mynix;
let cfg = config.mynix.home;
in
{
  # imports = with inputs; [
  #   home-manager.nixosModules.home-manager
  # ];

  options.mynix.home = with types; {
    file = mkOpt attrs { }
      (mdDoc "A set of files to be managed by home-manager's `home.file`.");
    configFile = mkOpt attrs { }
      (mdDoc "A set of files to be managed by home-manager's `xdg.configFile`.");
    extraOptions = mkOpt attrs { } "Options to pass directly to home-manager.";
  };

  config = {
    mynix.home.extraOptions = {
      home.stateVersion = config.system.stateVersion;
      home.file = mkAliasDefinitions options.mynix.home.file;
      xdg.enable = true;
      xdg.configFile = mkAliasDefinitions options.mynix.home.configFile;
    };

    home-manager = {
      useUserPackages = true;
      useGlobalPkgs = true;

      users.${config.mynix.user.name} =
        mkAliasDefinitions options.mynix.home.extraOptions;
    };
  };
}
