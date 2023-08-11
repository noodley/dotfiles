{ config, ... }:
{
  programs.bash = {
    enable = true;
    shellAliases = {
      vi = "nvim";
      vim = "nvim";
    };
    shellOptions = [ ];
    bashrcExtra = ''
      set -o vi
    '';
  };
  home.persistence = {
    "/persist/root/home/${config.home.username}" = {
      files = [
        ".bash_history"
      ];
    };
  };
}
