{firefox-addons}: {
  id = 0;
  isDefault = true;
  extensions = with firefox-addons; [
    betterttv
  ];
  settings = {
    "extensions.autoDisableScopes" = 0;
  };
  search = {
    engines = {
      "NixOs Packages" = {
        urls = [
          {
            template = "https://search.nixos.org/packages";
            params = [
              {
                name = "channel";
                value = "unstable";
              }
              {
                name = "type";
                value = "packages";
              }
              {
                name = "query";
                value = "{searchTerms}";
              }
            ];
          }
        ];
        iconUpdateURL = "https://search.nixos.org/favicon.png";
        updateInterval = 24 * 60 * 60 * 1000; # every day
        definedAliases = ["@nxp"];
      };
      "NixOs Options" = {
        urls = [
          {
            template = "https://search.nixos.org/options";
            params = [
              {
                name = "channel";
                value = "unstable";
              }
              {
                name = "type";
                value = "options";
              }
              {
                name = "query";
                value = "{searchTerms}";
              }
            ];
          }
        ];
        iconUpdateURL = "https://search.nixos.org/favicon.png";
        updateInterval = 24 * 60 * 60 * 1000; # every day
        definedAliases = ["@nxo"];
      };
    };
  };
}
