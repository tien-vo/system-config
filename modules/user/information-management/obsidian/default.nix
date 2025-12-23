{ config, ... }:
{
  config.programs.obsidian = {
    enable = true;
    #  defaultSettings = {
    #    app = {
    #      promptDelete = false;
    #      vimMode = true;
    #      alwaysUpdateLinks = true;
    #      newFileLocation = "folder";
    #      newFileFolderPath = "notes";
    #    };
    #    appearance = {
    #      cssTheme = "Material Gruvbox";
    #    };
    #    themes = [
    #      "Material Gruvbox"
    #    ];
    #    communityPlugins = [
    #      "obsidian-excalidraw-plugin"
    #      "pdf-plus"
    #    ];
    #    corePlugins = [
    #      "file-explorer"
    #      "global-search"
    #      "switcher"
    #      "graph"
    #      "backlink"
    #      "canvas"
    #      "outgoing-link"
    #      "tag-pane"
    #      "page-preview"
    #      "daily-notes"
    #      "templates"
    #      "note-composer"
    #      "command-palette"
    #      "editor-status"
    #      "bookmarks"
    #      "outline"
    #      "word-count"
    #      "file-recovery"
    #    ];
    #  };
  };
}
