{ ... }:
let
  prefix = "https://addons.mozilla.org/firefox/downloads/latest";
  addonList = map (name: "${prefix}/${name}/latest.xpi") ([
    "ublock-origin"
    "bitwarden-password-manager"
    "sidebery"
  ]);
in
{
  config.programs.firefox.policies = {
    DisableAppUpdate = true;
    DisableSystemAddonUpdate = true;
    DisableProfileImport = true;
    DisableFirefoxStudies = true;
    DisableTelemetry = true;
    DisableFeedbackCommands = true;
    DisablePocket = true;
    DisableDeveloperTools = false;
    NoDefaultBookmarks = true;
    OverrideFirstRunPage = "";
    WebsiteFilter = {
      Block = [
        "https://localhost/*"
      ];
      Exceptions = [
        "https://localhost/*"
      ];
    };
    Extensions = {
      Install = addonList;
      Uninstall = [
        "google@search.mozilla.org"
        "bing@search.mozilla.org"
        "amazondotcom@search.mozilla.org"
        "ebay@search.mozilla.org"
        "wikipedia@search.mozilla.org"
      ];
    };
    SearchEngines = {
      PreventInstalls = false;
      Remove = [
        "Google"
        "Bing"
        "Amazon.com"
        "eBay"
        "Wikipedia"
      ];
      Default = "StartPage";
      Add = [
        {
          Name = "StartPage";
          Description = "The world's most private search engine";
          Alias = "";
          Method = "GET";
          URLTemplate = "https://www.startpage.com/sp/search?query={searchTerms}&cat=web&pl=opensearch";
          IconURL = "https://www.startpage.com/favicon.ico";
        }
      ];
    };
  };
}
