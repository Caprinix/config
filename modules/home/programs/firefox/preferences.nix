let
  locked-false = {
    Value = false;
    Status = "locked";
  };
in {
  "browser.newtabpage.activity-stream.showSponsored" = locked-false;
  "browser.newtabpage.activity-stream.showSponsoredTopSites" = locked-false;
  "browser.newtabpage.activity-stream.system.showSponsored" = locked-false;
}
