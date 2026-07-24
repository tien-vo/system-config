{ config, settings, inputs, ... }:
let
  inherit (settings) arch;

  pkgs = import inputs.obsidian-plugins.inputs.nixpkgs({
    system = arch;
    overlays = [ inputs.obsidian-plugins.overlays.default ];
  });

  material-gruvbox = pkgs.stdenvNoCC.mkDerivation {
    pname = "obsidian-theme-material-gruvbox";
    version = "1";

    src = ./assets/themes/material-gruvbox;

    installPhase = ''
      runHook preInstall

      mkdir -p "$out"
      cp manifest.json theme.css "$out/"

      runHook postInstall
    '';
  };

  vault = "70_collections/02_obsidian-vault";
in
{
  config.programs.obsidian = {
    enable = true;

    vaults.personal = {
      target = vault;

      settings = {
        corePlugins = [
          "backlink"
          "bases"
          "bookmarks"
          "canvas"
          "command-palette"
          "daily-notes"
          "file-recovery"
          "file-explorer"
          "graph"
          "note-composer"
          "outgoing-link"
          "outline"
          "page-preview"
          "switcher"
          "global-search"
          "tag-pane"
          "templates"
          "word-count"
        ];

        communityPlugins = with pkgs.obsidianPlugins; [
          {
            pkg = obsidian-excalidraw-plugin;
            settings = {
              embedUseExcalidrawFolder = true;

              folder = "01_workspace/01_excalidraw";
              annotateFolder = "01_workspace/02_workbench/drawings";

              cropFolder = "90_resources/01_excalidraw/cropped";
              templateFilePath = "90_resources/05_templates/01_excalidraw";
              scriptFolderPath = "90_resources/05_templates/01_excalidraw/scripts";

              cropPrefix = "cropped_";
              cropSuffix = "";

              pinnedScripts = [
                "90_resources/01_excalidraw/scripts/Downloaded/Text Aura.md"
              ];

              startupScriptPath = "";
            };
          }
          
          pdf-plus
        ];

        themes = [
          {
            pkg = material-gruvbox;
            enable = true;
          }
        ];

        app = {
          alwaysUpdateLinks = true;
          vimMode = true;
        };
      };
    };
  };

  config.home.file = {
    "${vault}/.obsidian/app.json".force = true;
    "${vault}/.obsidian/appearance.json".force = true;
    "${vault}/.obsidian/core-plugins.json".force = true;
    "${vault}/.obsidian/community-plugins.json".force = true;
    "${vault}/.obsidian/plugins/obsidian-excalidraw-plugin/data.json".force = true;
  };
}
