{
  lib,
  config,
  pkgs,
  ...
}: let
  inherit (lib) mkEnableOption listToAttrs;
  inherit (lib.caprinix) mkIfEnabled enabled;
  inherit (lib.snowfall) fs path;

  cfg = config.caprinix.programs.firefox;

  preferences = import ./preferences.nix;
  extensionSettings = import ./extension-settings.nix;
  profileFiles = fs.get-nix-files-recursive ./profiles;
  getName = file: path.get-file-name-without-extension file;
  inherit (pkgs.nur.repos.rycee) firefox-addons;
in {
  options.caprinix.programs.firefox = {
    enable = mkEnableOption "firefox";
  };

  config = mkIfEnabled cfg {
    programs = {
      firefox =
        enabled
        // {
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
          profiles = listToAttrs (
            map (profile: {
              name = getName profile;
              value = import profile {inherit firefox-addons;};
            })
            profileFiles
          );
        };
    };
  };
}
