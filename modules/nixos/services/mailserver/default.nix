{
  lib,
  config,
  ...
}: let
  inherit (lib) mkEnableOption;
  inherit (lib.caprinix) enabled mkIfEnabled;

  cfg = config.caprinix.services.mailserver;
in {
  options.caprinix.services.mailserver = {
    enable = mkEnableOption "mailserver";
  };

  config = mkIfEnabled cfg {
    mailserver =
      enabled
      // {
        inherit (config.networking) fqdn;
        domains = ["replicapra.dev" "liebesplural.club"];
        dkimKeyBits = 4096;
        openFirewall = true;
        enableImap = false;
        enableSubmission = false;
        enableManageSieve = true;
        certificateScheme = "acme-nginx";
        loginAccounts = {
          "default@replicapra.dev" = {
            aliases = map (domain: "@${domain}") config.mailserver.domains;
            hashedPasswordFile = config.sops.secrets."services/mailserver/accounts/default/password".path;
          };
          "noreply@replicapra.dev" = {
            sendOnly = true;
            hashedPasswordFile = config.sops.secrets."services/mailserver/accounts/noreply/password".path;
          };
        };
        mailboxes = {
          Archive = {
            auto = "subscribe";
            specialUse = "Archive";
          };
          Drafts = {
            auto = "subscribe";
            specialUse = "Drafts";
          };
          Sent = {
            auto = "subscribe";
            specialUse = "Sent";
          };
          Junk = {
            auto = "subscribe";
            specialUse = "Junk";
            autoexpunge = "30d";
          };
          Trash = {
            auto = "subscribe";
            specialUse = "Trash";
            autoexpunge = "30d";
          };
        };
        useFsLayout = true;
      };

    security.acme.acceptTerms = true;
    security.acme.defaults.email = "security@replicapra.dev";
  };
}
