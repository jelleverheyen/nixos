{
  inputs,
  pkgs,
  lib,
  ...
}:
let
  extension = shortId: guid: {
    name = guid;
    value = {
      install_url = "https://addons.mozilla.org/en-US/firefox/downloads/latest/${shortId}/latest.xpi";
      installation_mode = "normal_installed";
    };
  };

  extensions = [
    # To add additional extensions, find it on addons.mozilla.org, find
    # the short ID in the url (like https://addons.mozilla.org/en-US/firefox/addon/!SHORT_ID!/)
    # Then go to https://addons.mozilla.org/api/v5/addons/addon/!SHORT_ID!/ to get the guid
    (extension "ublock-origin" "uBlock0@raymondhill.net")
    (extension "proton-pass" "78272b6fa58f4a1abaac99321d503a20@proton.me")
    (extension "sponsorblock" "sponsorBlocker@ajay.app")
    (extension "enhancer-for-youtube" "enhancerforyoutube@maximerf.addons.mozilla.org")
    # ...
  ];

  # Changes about:config
  prefs = {
    "extensions.autoDisableScopes" = 0;

    # Disable Mozilla telemetry
    "datareporting.healthreport.uploadEnabled" = false;
    "toolkit.telemetry.enabled" = false;
    "toolkit.telemetry.unified" = false;
    "toolkit.telemetry.archive.enabled" = false;
    "browser.ping-centre.telemetry" = false;

    # Disable studies/experiments
    "app.shield.optoutstudies.enabled" = false;

    # Disable Pocket
    "extensions.pocket.enabled" = false;

    # Disable default autofill
    "extensions.formautofill.addresses.enabled" = false;
    "extensions.formautofill.creditCards.enabled" = false;
    "dom.forms.autocomplete.formautofill" = false;

    # Disable sponsored stuff
    "browser.newtabpage.activity-stream.showSponsored" = false;
    "browser.newtabpage.activity-stream.showSponsoredTopSites" = false;

    # Safer referrer handling
    "network.http.referer.XOriginPolicy" = 2;

    # Use DNS over HTTPS, fallback to system DNS
    "network.trr.mode" = 2;
    "network.trr.uri" = "https://dns.quad9.net/dns-query";

    # Restore previous session
    "browser.startup.page" = 3;

    # Don't close window when closing last tab
    "browser.tabs.closeWindowWithLastTab" = false;

    # Compact mode
    "browser.compactmode.show" = true;

    # Enable search Suggestions
    "browser.search.suggest.enabled" = true;
    "browser.urlbar.suggest.searches" = true;
    "browser.urlbar.quicksuggest.enabled" = false;

    # Better find behavior
    "findbar.highlightAll" = true;

    # Disable annoying fullscreen warning
    "full-screen-api.warning.delay" = 0;
    "full-screen-api.warning.timeout" = 0;

    # Native file picker
    "widget.use-xdg-desktop-portal.file-picker" = 1;

    # Better scrolling
    "general.smoothScroll" = true;
    "general.autoScroll" = true;
    "mousewheel.default.delta_multiplier_y" = 300;

    # Force HTTPS
    "dom.security.https_only_mode" = true;

    # Increase process count
    "dom.ipc.processCount" = 12;

    # Disable built-in password manager
    # Disable Firefox password manager
    "signon.rememberSignons" = false;

    # Disable autofill of logins/forms
    "signon.autofillForms" = false;

    # Disable breach alerts
    "signon.management.page.breach-alerts.enabled" = false;

    # Disable password generation prompts
    "signon.generation.enabled" = false;

    # Better copy/paste UX
    "middlemouse.paste" = false;

    # Restore closed tabs
    "browser.sessionstore.max_tabs_undo" = 50;

    # Better URL bar
    "browser.urlbar.trimURLs" = false;

    # Native PDF viewer improvements
    "pdfjs.enableScripting" = false;

    # Prevent autoplay
    "media.autoplay.default" = 1;
  };

in
{
  environment.systemPackages = [
    (pkgs.wrapFirefox
      inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.zen-browser-unwrapped
      {
        extraPrefs = lib.concatLines (
          lib.mapAttrsToList (
            name: value: "lockPref(${lib.strings.toJSON name}, ${lib.strings.toJSON value});"
          ) prefs
        );

        extraPolicies = {
          DisableTelemetry = true;
          ExtensionSettings = builtins.listToAttrs extensions;
          DisableFirefoxAccounts = true;
          HardwareAcceleration = true;
          PasswordManagerEnabled = false;

          EnableTrackingProtection = {
            Value = true;
            Locked = true;
            Cryptomining = true;
            Fingerprinting = true;
          };

          SearchEngines = {
            Default = "Kagi";

            Add = [
              {
                Name = "Kagi";
                URLTemplate = "https://kagi.com/search?q={searchTerms}";
                # SuggestURLTemplate = "https://kagi.com/api/autosuggest?q={searchTerms}";
                SuggestURLTemplate = "https://kagisuggest.com/api/autosuggest?q={searchTerms}";

                IconURL = "https://kagi.com/favicon.ico";

                Alias = "@k";
              }
            ];
          };
        };
      }
    )
  ];
}
