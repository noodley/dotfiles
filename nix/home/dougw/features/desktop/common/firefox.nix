{ pkgs, lib, inputs, ... }:

let
  addons = inputs.firefox-addons.packages.${pkgs.system};
in
{
  programs.browserpass.enable = true;
  programs.firefox = {
    enable = true;
    profiles.dougw = {
      bookmarks = { };
      extensions = with addons; [
        ublock-origin
      ];
      bookmarks = { };
      settings = { };
    };
  };

#  home = {
#    persistence = { };
#  };

  xdg.mimeApps.defaultApplications = {
    "text/html" = [ "firefox.desktop" ];
    "text/xml" = [ "firefox.desktop" ];
    "x-scheme-handler/http" = [ "firefox.desktop" ];
    "x-scheme-handler/https" = [ "firefox.desktop" ];
  };
}
