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
}
