{ ... }:
{
  Extensions = {
    Install = [
      "https://addons.thunderbird.net/thunderbird/downloads/latest/gruvbox-dark-thunderbird/latest.xpi"
    ];
    Uninstall = [
      "google@search.mozilla.org"
      "bing@search.mozilla.org"
      "amazondotcom@search.mozilla.org"
      "ebay@search.mozilla.org"
      "wikipedia@search.mozilla.org"
    ];
  };
  ExtensionSettings = {
    "google@search.mozilla.org".installation_mode = "blocked";
    "bing@search.mozilla.org".installation_mode = "blocked";
    "amazondotcom@search.mozilla.org".installation_mode = "blocked";
    "ebay@search.mozilla.org".installation_mode = "blocked";
    "wikipedia@search.mozilla.org".installation_mode = "blocked";
  };
  SearchEngines = {
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
}
