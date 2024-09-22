{
  lib,
  config,
  ...
}:
let
  inherit (lib) mkEnableOption;
  inherit (lib.caprinix) mkIfEnabled enabled;

  cfg = config.caprinix.programs.firefox;

  preferences = import ./preferences.nix;
  extensionSettings = import ./extension-settings.nix;
in
{
  options.caprinix.programs.firefox = {
    enable = mkEnableOption "firefox";
  };

  config = mkIfEnabled cfg {
    programs = {
      firefox = enabled // {
        languagePacks = [
          "en-GB"
          "de"
        ];
        policies = {
          AutofillAddressEnabled = false;
          AutofillCreditCardEnabled = false;
          DisableProfileImport = true;
          DisableSetDesktopBackground = true;
          DisplayBookmarksToolbar = "always";
          DontCheckDefaultBrowser = true;
          EnableTrackingProtection = {
            Value = true;
            Locked = true;
            Cryptomining = true;
            Fingerprinting = true;
          };
          ExtensionSettings = extensionSettings;
          OfferToSaveLogins = false;
          PasswordManagerEnabled = false;
          Preferences = preferences;
          SanitizeOnShutdown = {
            Cache = true;
            Cookies = false;
            History = true;
            Sessions = false;
            SiteSettings = false;
            OfflineApps = false;
            Locked = true;
          };
        };
      };
    };
  };
}
