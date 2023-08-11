{ lib, ... }: {
  i18n = {
    defaultLocale = lib.mkDefault "en_US.UTF-8";
    extraLocaleSettings = { };
    supportedLocales = lib.mkDefault [
      "en_US.UTF-8/UTF-8"
    ];
  };
  time.timeZone = lib.mkDefault "America/Los_Angeles";
}
