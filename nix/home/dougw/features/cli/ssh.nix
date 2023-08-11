{ outputs, config, lib, ... }:
{
  programs.ssh = {
    enable = true;
  };

  home.persistence = {
    "/persist/root/home/${config.home.username}" = {
      directories = [
        ".ssh"
      ];
    };
  };
}
