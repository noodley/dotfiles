{ options, config, lib, pkgs, inputs, ... }:

with lib;
with lib.mynix;
let
  cfg = config.mynix.apps.firefox;
  browser-addons = inputs.firefox-addons.packages.${pkgs.system};

  defaultSettings = {
    ## Flags
    # General
    "browser.disableResetPrompt" = false;
    "browser.onboarding.enabled" = false;
    "browser.aboutConfig.showWarning" = false;
    "browser.sessionstore.interval" = "1800000";
    "browser.toolbars.bookmarks.visibility" = "never";
    "browser.urlbar.showSearchSuggestionsFirst" = false;
    "browser.urlbar.speculativeConnect.enabled" = false;
    "browser.urlbar.dnsResolveSingleWordsAfterSearch" = 0;
    "browser.download.panel.shown" = true;
    "browser.download.useDownloadDir" = false;
    "browser.shell.checkDefaultBrowser" = false;
    "browser.shell.defaultBrowserCheckCount" = 1;
    "browser.startup.homepage" = "https://start.duckduckgo.com";
    ## This is no longer respected and we need a policy
    #"browsear.search.defaultengine" = "DuckDuckGo";
    "dom.security.https_only_mode" = true;

    # Features
    "browser.search.openintab" = true;
    "layout.spellcheckDefault" = 2;

    # New Tab
    "browser.newtabpage.activity-stream.feeds.section.highlights" = false;
    "browser.newtabpage.activity-stream.feeds.section.topstories" = false;
    "browser.newtabpage.activity-stream.feeds.topsites" = false;
    "browser.newtabpage.activity-stream.showSearch" = true;
    "browser.newtabpage.activity-stream.showSponsored" = false;
    "browser.newtabpage.activity-stream.showSponsoredTopSites" = false;
    "browser.newtabpage.activity-stream.section.highlights.includePocket" = false;
    "browser.newtabpage.activity-stream.feeds.section.highlights.includePocket" = false;

    # Theming
    "browser.uidensity" = 0;
    "devtools.theme" = "dark";
    "layers.acceleration.force-enabled" = true;
    "mozilla.widget.use-argb-visuals" = true;
    "svg.context-properties.content.enabled" = true;
    "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
    "browser.uiCustomization.state" = ''{"placements":{"widget-overflow-fixed-list":[],"nav-bar":["back-button","forward-button","stop-reload-button","home-button","urlbar-container","downloads-button","library-button","ublock0_raymondhill_net-browser-action"],"toolbar-menubar":["menubar-items"],"TabsToolbar":["tabbrowser-tabs","new-tab-button","alltabs-button"],"PersonalToolbar":["import-button","personal-bookmarks"]},"seen":["save-to-pocket-button","developer-button","ublock0_raymondhill_net-browser-action"],"dirtyAreaCache":["nav-bar","PersonalToolbar","toolbar-menubar","TabsToolbar","widget-overflow-fixed-list"],"currentVersion":18,"newElementCount":4}'';

    # Passwords
    "signon.autofillForms" = false;
    "signon.rememberSignons" = false;
    "signon.generation.enabled" = false;
    "signon.management.page.breach-alerts.enabled" = false;

    # Extensions
    "extensions.pocket.enabled" = false;
    "extensions.htmlaboutaddons.inline-options.enabled" = false;
    "extensions.htmlaboutaddons.recommendations.enabled" = false;

    # Security
    "security.family_safety.mode" = 0;
    "security.pki.sha1_enforcement_level" = 1;
    "security.tls.enable_0rtt_data" = false;

    # Reports
    "breakpad.reportURL" = "";
    "browser.crashReports.unsubmittedCheck.autoSubmit2" = false;
    "browser.tabs.crashReporting.sendReport" = false;
    "datareporting.healthreport.service.enabled" = false;
    "datareporting.healthreport.uploadEnabled" = false;
    "datareporting.policy.dataSubmissionEnabled" = false;

    # Telemetry
    "app.normandy.api_url" = "";
    "app.normandy.enabled" = false;
    "app.shield.optoutstudies.enable" = false;
    "beacon.enabled" = false;
    "browser.newtabpage.activity-stream.feeds.telemetry" = false;
    "browser.newtabpage.activity-stream.telemetry" = false;
    "browser.ping-centre.telemetry" = false;
    "browser.send_pings" = false;
    "browser.urlbar.suggest.quicksuggest.nonsponsored" = false;
    "dom.battery.enabled" = false;
    "dom.gamepad.enabled" = false;
    "experiments.enabled" = false;
    "experiments.manifest.uri" = "";
    "experiments.supported" = false;
    "toolkit.coverage.endpoint.base" = "";
    "toolkit.coverage.opt-out" = true;
    "toolkit.telemetry.archive.enabled" = false;
    "toolkit.telemetry.bhrPing.enabled" = false;
    "toolkit.telemetry.coverage.opt-out" = true;
    "toolkit.telemetry.enabled" = false;
    "toolkit.telemetry.firstShutdownPing.enabled" = false;
    "toolkit.telemetry.newProfilePing.enabled" = false;
    "toolkit.telemetry.reportingpolicy.firstRun" = false;
    "toolkit.telemetry.server" = "data:,";
    "toolkit.telemetry.shutdownPingSender.enabled" = false;
    "toolkit.telemetry.unified" = false;
    "toolkit.telemetry.updatePing.enabled" = false;
  };
in
{
  options.mynix.apps.firefox = with types; {
    enable = mkBoolOpt false "Whether or not to enable Firefox.";
    extraConfig =
      mkOpt str "" "Extra configuration for the user profile JS file.";
    userChrome =
      mkOpt str "" "Extra configuration for the user chrome CSS file.";
    settings = mkOpt attrs defaultSettings "Settings to apply to the profile.";
  };

  config = mkIf cfg.enable {
    mynix.desktop.addons.firefox-nordic-theme = enabled;

    mynix.home = {
      extraOptions = {
        programs.firefox = {
          enable = true;
          profiles.${config.mynix.user.name} = {
	    bookmarks = { };
	    extensions = with browser-addons; [ 
	      ublock-origin 
	    ];
            inherit (cfg) extraConfig userChrome settings;
            id = 0;
            name = config.mynix.user.name;
          };
        };
      };
    };
  };
}
