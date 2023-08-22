{ options, config, pkgs, lib, ... }:

with lib;
with lib.mynix;
let
  cfg = config.mynix.hardware.audio;
in
{
  options.mynix.hardware.audio = with types; {
    enable = mkBoolOpt false "Whether or not to enable audio support.";
    extra-packages = mkOpt (listOf package) [ ] "Additional packages to install.";
  };

  config = mkIf cfg.enable {
    security.rtkit.enable = true;

    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;

      wireplumber.enable = true;
    };

    hardware.pulseaudio.enable = mkForce false;

    environment.systemPackages = with pkgs; [
      pulsemixer
    ] ++ cfg.extra-packages;

    mynix.user.extraGroups = [ "audio" ];
  };
}
