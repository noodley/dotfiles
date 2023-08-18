{ config, pkgs, lib, ... }: {
  environment.systemPackages = with pkgs; [
    yubikey-personalization
    gnupg
    pinentry-qt
  ];

  programs = {
    ssh.startAgent = false;
  };

  services.pcscd.enable = true;
  services.udev.packages = [ pkgs.yubikey-personalization ];

  environment.shellInit = ''
    gpg-connect-agent /bye
    export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)
  '';

}
