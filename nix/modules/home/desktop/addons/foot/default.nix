{ lib, config, pkgs, ... }:

let
  inherit (lib) types mkEnableOption mkIf;
  cfg = config.mynix.desktop.addons.foot;
in
{
  options.mynix.desktop.addons.foot = {
    enable = mkEnableOption "enable and configure foot";
  };

  config = mkIf cfg.enable {
    programs.foot = {
      enable = true;
      settings = {
        main = {
	  font = "Hack Nerd Font Mono:size=8";
          underline-offset = 2;
          pad = "20x4 center";
          term = "xterm-256color";
          dpi-aware = "yes";
        };
        scrollback = {
          lines = 2000;
	};

        url = {
          protocols = "http,https,ftp,ftps,file,gemini,gopher,mailto";
	};

        cursor = {
          blink = "yes";
	};

        colors = {
          # Nord
          foreground = "D8DEE9";
          background = "2E3440";

          regular0 = "2E3440";
          regular1 = "BF616A";
          regular2 = "A3BE8C";
          regular3 = "EBCB8B";
          regular4 = "81A1C1";
          regular5 = "B48EAD";
          regular6 = "88C0D0";
          regular7 = "E5E9F0";

          bright0 = "4C566A";
          bright1 = "BF616A";
          bright2 = "A3BE8C";
          bright3 = "EBCB8B";
          bright4 = "8FBCBB";
          bright5 = "B48EAD";
          bright6 = "8FBCBB";
          bright7 = "ECEFF4";
        };
        csd = {
          size = 0;
	};
      };
    };
  };
}
