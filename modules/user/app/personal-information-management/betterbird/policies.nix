{ ... }:
{
  Extensions = {
    Install = [
      "https://addons.thunderbird.net/thunderbird/downloads/latest/gruvbox-dark-thunderbird/latest.xpi"
    ];
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
