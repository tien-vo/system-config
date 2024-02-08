{ config, pkgs, settings, ... }:
let
in pkgs.writeTextFile ({
  name = "userChrome.css";
  text = ''
    * {border: 0 !important; }

    /*change background color and text color of zotero toolbar and menubar*/
    #zotero-tb, #zotero-toolbar, #navigator-toolbox, #tab-bar-container { background: #323234 !important;
    color: #FFFFFF !important; }
    #zotero-toolbar {border-bottom: 1px solid #1d1d1d !important;}

    /*change color of menu items to white*/
    #navigator-toolbox menu { color: white !important }

    /*change color of menu items in drop down menus back to black*/
    #manage-attachments-menu label, #developer-menu label, #layout-menu label, #note-font-size-menu label, #font-size-menu label, #debug-output-menu label, #new-item label { color: black !important; }

    /*Fixed New Item showing in white*/
    #navigator-toolbox menu:first-child { color: unset !important; }

    /*Change color of tags selector below collections tree*/
    #zotero-tag-selector-container {  border-bottom: 1px solid #1d1d1d !important;
      border-top:1px solid #1d1d1d !important;}

    #zotero-tag-selector-container input { -moz-appearance: none !important;
      background: #474749 !important;
      border: 1px solid #1d1d1d !important;
      color: white !important; }

    .tag-selector-list-container {-moz-appearance: none !important;
      background: #474749 !important;
      color: white !important; }

    /* for Zotero 6*/
    .tag-selector-item:hover { background: #BBCEF1 !important;
        color: black !important; }

    .tag-selector-item {
      background: #474749 !important;
    color:white ; }

    .tag-selector-item.selected { background: #7E7E7E !important;
        font-weight: bold !important; }

    .tag-selector-item.selected:hover { background: #BBCEF1 !important;
        font-weight: bold !important; }

    #zotero-tb-search { -moz-appearance: none !important;
      background-color: #474749 !important;
      color: white !important;
      border: 1px solid #1d1d1d !important; }

    #zotero-pane { background: #323234 !important;
    color: black !important; }

    /*change background and color of collections and items panes*/
    treechildren { background: #323234 !important;
    color: #FFFFFF !important; }

    /*for Zotero 6*/
    .virtualized-table .row{background: #323234 !important; color: #FFFFFF !important;}
    .virtualized-table .row.highlighted {background: #BBCEF1 !important; color: black !important;}
    .virtualized-table .row.selected {background: #474749 !important; border: 0 !important;
    border-bottom: 1px solid #1d1d1d !important;}
    .virtualized-table:not(:focus) .row.selected {background: #474749 !important; border: 0 !important;
    border-bottom: 1px solid #1d1d1d !important;}
    .row:hover { background: #7E7E7E !important;
    color: #FFFFFF !important; border: 0 !important; }


    .tabs {  background: #474749 !important;
      color: #FFFFFF !important;
    border: 0px !important; }

    .tab {-moz-appearance: none !important;
    color: #7E7E7E !important;
    background: #474749 !important;
    border-left: 0px solid rgba(127,127,127) !important;
    border-right: 0px solid rgba(127,127,127) !important;}

    .tab:hover { background: #7E7E7E !important;
    color: #FFFFFF !important;
    border: 0px !important; }

    .tab:not(:focus){ -moz-appearance: none !important;
    color: #7E7E7E ;
    background: #474749 ;
    border-top: 0px solid #0a84ff !important;
    border-left: 1px solid rgba(127,127,127) !important;
    border-right: 0px solid rgba(127,127,127) !important;
    border-radius: 0px !important;
    border-bottom-left-radius: 0px !important;
    border-bottom-right-radius: 0px !important; }

    .tab.selected:not(.highlighted){ color: #FFFFFF !important;
      background: #323234 !important;
      border-top: 3px solid #0a84ff !important;
      border-left: 0px solid rgba(127,127,127) !important;
      border-right: 0px solid #1d1d1d !important;
      border-radius: 0px !important;
      border-bottom-left-radius: 0px !important;
      border-bottom-right-radius: 0px !important; }

    .tab-close:hover { background: #7E7E7E !important; }

    /*PDF reader notes list*/
    .notes-list-container { background: #323234 !important;
    color: #ffffff !important; }

    .note-row {background: #474749 !important;
      color: #ffffff !important; }

    .note-row .date {color: #ffffff !important; }

    .more-row { background: #474749 !important;
      color: #ffffff !important; }

    .note-row:hover, .more-row:hover {background: #7E7E7E !important;
    color: #FFFFFF !important; }

    /*collections tree background*/
    #zotero-collections-tree { color: #ffffff; background: #323234 !important; }
    /*increase spacing between rows in collections and items and add a border to separate panes (not working on zotero 6)*/
    /*#zotero-collections-tree treechildren::-moz-tree-row { height: 30px !important; }
    .virtualized-table { rowHeight: 30px !important; } */
    /*change background and color of collections when hovering*/
    #zotero-collections-tree treechildren::-moz-tree-row(hover) { background: #7E7E7E !important;
    color: #FFFFFF !important; border: 0 !important; }

    /*change color of selected item in Collections pane (My library or folders) */
    #zotero-collections-tree treechildren::-moz-tree-cell(selected) { background: #474749 !important; border: 0 !important;
    border-bottom: 1px solid #1d1d1d !important; }

    #zotero-collections-tree treechildren::-moz-tree-cell-text(selected) { color: #FFFFFF !important; }

    #zotero-collections-tree treechildren { border-right: 1px solid #1d1d1d !important ; }
    /*for Zotero 6*/
    #zotero-collections-tree  .virtualized-table {border-right: 1px solid #1d1d1d !important ; }
    /*increase spacing between rows in collections and items (-moz-tree-row not working in zotero 6)*/
    /*#zotero-items-tree treechildren::-moz-tree-row { height: 30px !important; }*/
    #zotero-items-tree { border-right: 1px solid #1d1d1d !important;
    border-bottom: 1px solid #1d1d1d !important; 
    color: #ffffff; background: #323234 !important; }

    /*change background and color of items when hovering*/
    #zotero-items-tree treechildren::-moz-tree-row(hover) { background: #7E7E7E !important;
    color: #FFFFFF !important; border: 0 !important; }

    /*change background and color of items when selecting*/
    #zotero-items-tree treechildren::-moz-tree-row(selected) { background: #474749 !important;
    color: #FFFFFF !important; border: 0 !important;
    border-bottom: 1px solid #1d1d1d !important; }
    #zotero-items-tree treechildren::-moz-tree-cell-text(selected) { color: #FFFFFF !important; border: 0 !important; }

    /*change background and color of columns field selector*/
    #zotero-items-tree treecol { -moz-appearance: none !important;
      background: #474749 !important;
    color: #FFFFFF !important;
    border-bottom: 1px solid #1d1d1d !important;
    border-right: 1px solid #1d1d1d !important; }

    /*fix columns field selector for Zotero 6*/
    #zotero-items-tree .virtualized-table-header { -moz-appearance: none !important;
      background: #474749 !important;
    color: #FFFFFF !important;
    border-bottom: 1px solid #1d1d1d !important;
    border-right: 1px solid #1d1d1d !important; }

    #zotero-items-tree .virtualized-table-header .cell:hover { background: #7E7E7E !important;
    color: #FFFFFF !important;}

    .treecol-image { -moz-appearance: none !important;
      background: #474749 !important;
    color: #FFFFFF !important;
    border-bottom: 1px solid #1d1d1d !important; }

    /*Change color of fields in item pane (clicky items) when hovering */
    #zotero-item-pane-content .zotero-clicky:hover
    {	color: black !important;
      border-radius: 0px !important; }

    #better-bibtex-citekey-display { color: white !important; }

    /*change color of buttons, but messes with .zotero-clicky-minus and .zotero-clicky-plus in Tags tab*/

    /*Correct Minus and plus clicky buttons */
    #zotero-item-pane-content .zotero-clicky-minus:hover { color: transparent !important;}
    #zotero-item-pane-content .zotero-clicky-plus:hover { color: transparent !important;}

    /*tabs in Preferences dialog - well more like all the tabs except the ones I'll specify later*/
    tabpanel { color: black !important;
    background: #7E7E7E !important; }

    tab[selected="true"] { color: black !important;
    background: #7E7E7E !important;
    border-top: 3px solid #0a84ff !important; }

    tab { -moz-appearance: none !important;
    color: #eee !important;
    background: #474749 !important;
    border-top: 0px solid black !important;
    border-left: 0px solid black !important;
    border-right: 1px solid #1d1d1d !important;
    border-radius: 0px !important;
    border-bottom-left-radius: 0px !important;
    border-bottom-right-radius: 0px !important; }

    tab:hover { color: black !important;
    background: #E0E8F6 !important;
    box-shadow: inset 0px 0px 0px !important;
    border-radius: 0px 0px 0 0 !important; }

    /*change items in item pane besides tabs*/
    #zotero-duplicates-merge-pane > groupbox > .groupbox-body { background: #323234 !important;
      color: #FFFFFF !important;
      border: 0 !important; }

    #zotero-item-pane-content > groupbox > .groupbox-body { border: 0 !important; background: #323234 !important;
    color: #FFFFFF !important; }

    /*change color of retraction details background*/
    #retraction-details { background: #7f0000 !important; }

    /*background of item-pane-content (Zotero 6)*/
    .zotero-view-tabbox, .zotero-item-pane-content { background: #323234 !important; color: #FFFFFF !important; }

    /*tabs in Item pane*/
    #zotero-item-pane-content tabpanel { background: #474749 !important;
      color: white !important; }

    /*fixed color in drop-down tags: see https://css-tricks.com/solved-with-css-dropdown-menus/*/
    #tags-box-container ul li ul { background: #7E7E7E !important; color: white !important; }
    #tags-box-container input { -moz-appearance: none !important;
      background-color: #7E7E7E !important;
      color: white !important;
      border: 1px solid #1d1d1d !important;}

    /*In PDF reader tab pane*/
    .zotero-view-tabbox  .tags-box-container ul li ul { background: #7E7E7E !important; color: white !important; }
    .zotero-view-tabbox  .tags-box-container input { -moz-appearance: none !important;
        background-color: #7E7E7E !important;
        color: white !important;
        border: 1px solid #1d1d1d !important;}

    .zotero-view-tabbox tab[selected="true"]{ background: #474749 !important;
    border-top: 3px solid #0a84ff !important;}

    .zotero-view-tabbox tab { -moz-appearance: none !important;
    color: #eee !important;
    background: #323234 !important;
    border-top: 0px solid #0a84ff !important;
    border-left: 0px solid rgba(127,127,127,0.2) !important;
    border-right: 1px solid #1d1d1d !important;
    border-radius: 0px !important;
    border-bottom-left-radius: 0px !important;
    border-bottom-right-radius: 0px !important; }

    .zotero-view-tabbox tab:hover{ color: #FFFFFF !important;
    background: #7E7E7E !important; }

    .zotero-view-tabbox tabpanel { background: #474749 !important;
      color: #FFFFFF !important; }
      .zotero-view-tabbox .zotero-clicky:hover { color: black !important; }

    #zotero-item-pane-content tab[selected="true"]{ background: #474749 !important;
    border-top: 3px solid #0a84ff !important;}

    #zotero-item-pane-content tab { -moz-appearance: none !important;
    color: #eee !important;
    background: #323234 !important;
    border-top: 0px solid #0a84ff !important;
    border-left: 0px solid rgba(127,127,127,0.2) !important;
    border-right: 1px solid #1d1d1d !important;
    border-radius: 0px !important;
    border-bottom-left-radius: 0px !important;
    border-bottom-right-radius: 0px !important; }

    #zotero-item-pane-content tab:hover{ color: #FFFFFF !important;
    background: #7E7E7E !important;
    box-shadow: inset 0px 0px 0px !important;
    border-radius: 0px 0px 0 0 !important; }

    /*define color of item type field*/
    #item-type-menu { -moz-appearance: none;
      color: white !important;
      height: 1.5em !important;
      min-height: 1.5em !important;
      padding: 0 0 0 2px !important;
      margin: 1px 5px 0 1px !important;
      max-height: 1.5em !important;
      border: 1px solid transparent;
      background-color: transparent; }

    #item-type-menu:hover {	color: black !important; 
    background: #BBCEF1 !important; }

    /*define color of date-field-status*/
    #zotero-date-field-status { color: #ffffff !important;
      padding: 0 10px 0 1px !important; }

    /*preferences dialog*/
    #zotero-prefpane-general, #zotero-prefpane-sync, #zotero-prefpane-export, #zotero-prefpane-advanced-keys-tab, #wordProcessors, #zotero-quickCopy-format, #sync-reset-form, #zotero-export-options { color: black !important;
    background: #7E7E7E !important; }
    #zotero-prefpane-general title { background: #474749 !important;
    color: #FFFFFF !important; }

    prefwindow { color: black !important;
    background: #7E7E7E !important; }

    prefwindow .chromeclass-toolbar { color: #FFFFFF !important;
    background: #323234 !important; }

    /*about dialog*/
    #aboutcontent {	background: #474749 !important;
      color: white !important;
      padding: 10px; }

    #version { color: white !important; }

    /*advanced search dialog*/
    #zotero-advanced-search-dialog #zotero-search-box-controls { color: black !important;
    background: #7E7E7E !important; }

    /*Note editor - ongoing*/
    #zotero-note-editor linksbox { background-color: #474749 !important;
    color: white !important; }

    #zotero-note-window h1 { color: white;
    font-size: 1.6em;
    padding-bottom: none; }

    #zotero-note-window h2 { color: white;
    font-size: 1.4em;
    font-weight: bold;
    padding-bottom: none;
    border-bottom: none; }

    #zotero-note-window h3 { color: white;
    font-size: 1.2em; }

    #zotero-note-window p { text-indent: 1.75em; }

    #zotero-note-window ul, ol { padding-left: 1.75em; }

    #zotero-note-window blockquote { margin-top: 0;
    margin-bottom: 0;
    margin-left: 0;
    padding-left: 1.55em;
    border-left: 3px solid darkgrey;
    color: white (255, 248, 248); }

    #zotero-note-window blockquote p { text-indent: 0; }
  '';
})
