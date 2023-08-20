{ config, ... }:
{
  programs.bash = {
    enable = true;
    shellAliases = { };
    shellOptions = [ ];
    sessionVariables = { };
    bashrcExtra = ''
      set -o vi
    '';
    historyFile = "/persist/root/home/${config.home.username}/.bash_history";
    historyIgnore = [
      "ls"
      "exit"
    ];
  };
}
