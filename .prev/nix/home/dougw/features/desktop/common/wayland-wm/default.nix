{ pkgs, ... }:
{
  imports = [
    ./foot.nix
    ./swayidle.nix
    ./swaylock.nix
    ./waybar.nix
    #./wofi.nix
  ];

  xdg.mimeApps.enable = true;
  home.packages = with pkgs; [
    gtk3 # For gtk-launch
    wl-clipboard
  ];

  home.sessionVariables = {
    MOZ_ENABLE_WAYLAND = 1;
    QT_QPA_PLATFORM = "wayland";
    LIBSEAT_BACKEND = "logind";
  };
}
