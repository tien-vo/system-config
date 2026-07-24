#   # Generated via dconf2nix: https://github.com/gvolpe/dconf2nix
#   { config, pkgs, lib, ... }:
#   
#   with lib.hm.gvariant;
#   
#   {
#     config.home.packages = [
#       #  pkgs.dconf2nix 
#     ];
#   
#     #  config.dconf.settings = {
#     #    "com/github/wwmm/easyeffects" = {
#     #      last-used-input-preset = "Presets";
#     #      last-used-output-preset = "Gracefu's Edits";
#     #      use-dark-theme = true;
#     #      window-fullscreen = false;
#     #      window-height = 1090;
#     #      window-maximized = true;
#     #      window-width = 846;
#     #    };
#   
#     #    "com/github/wwmm/easyeffects/spectrum" = {
#     #      color = mkTuple [ 1.0 1.0 1.0 1.0 ];
#     #      color-axis-labels = mkTuple [ 1.0 1.0 1.0 1.0 ];
#     #    };
#   
#     #    "com/github/wwmm/easyeffects/streaminputs" = {
#     #      input-device = "alsa_input.pci-0000_c1_00.6.analog-stereo";
#     #    };
#   
#     #    "com/github/wwmm/easyeffects/streamoutputs" = {
#     #      blocklist = [];
#     #      output-device = "alsa_output.pci-0000_c1_00.6.analog-stereo";
#     #      plugins = [ "filter#0" "bass_enhancer#0" "convolver#0" "multiband_compressor#0" "stereo_tools#0" "limiter#0" ];
#     #    };
#   
#     #    "com/github/wwmm/easyeffects/streamoutputs/bassenhancer/0" = {
#     #      amount = 4.0;
#     #      bypass = true;
#     #      floor = 10.0;
#     #      floor-active = true;
#     #      harmonics = 10.0;
#     #      scope = 200.0;
#     #    };
#   
#     #    "com/github/wwmm/easyeffects/streamoutputs/convolver/0" = {
#     #      kernel-path = "/home/tvo/.config/easyeffects/irs/IR_22ms_27dB_5t_15s_0c.irs";
#     #      output-gain = 6.0;
#     #    };
#   
#     #    "com/github/wwmm/easyeffects/streamoutputs/convolver/1" = {
#     #      kernel-path = "/home/tvo/.config/easyeffects/irs/IR_22ms_16dB_5t_15s_0c.irs";
#     #    };
#   
#     #    "com/github/wwmm/easyeffects/streamoutputs/exciter/0" = {
#     #      amount = -3.0;
#     #      ceil = 15000.0;
#     #      harmonics = 10.0;
#     #    };
#   
#     #    "com/github/wwmm/easyeffects/streamoutputs/filter/0" = {
#     #      frequency = 60.0;
#     #      quality = 16.0;
#     #      slope = "x16";
#     #      type = "High-pass";
#     #      width = 1.0;
#     #    };
#   
#     #    "com/github/wwmm/easyeffects/streamoutputs/filter/1" = {
#     #      frequency = 120.0;
#     #      gain = 36.0;
#     #      type = "High-pass";
#     #    };
#   
#     #    "com/github/wwmm/easyeffects/streamoutputs/limiter/0" = {
#     #      attack = 2.0;
#     #      lookahead = 4.0;
#     #      oversampling = "Half x4(2L)";
#     #      release = 8.0;
#     #    };
#   
#     #    "com/github/wwmm/easyeffects/streamoutputs/multibandcompressor/0" = {
#     #      attack-threshold0 = -16.0;
#     #      attack-threshold1 = -24.0;
#     #      attack-threshold2 = -24.0;
#     #      attack-threshold3 = -24.0;
#     #      attack-time0 = 150.0;
#     #      attack-time1 = 150.0;
#     #      attack-time2 = 100.0;
#     #      attack-time3 = 80.0;
#     #      knee0 = -12.0;
#     #      knee1 = -9.0;
#     #      knee2 = -9.0;
#     #      knee3 = -9.0;
#     #      makeup0 = 0.0;
#     #      makeup1 = 5.0;
#     #      makeup2 = 5.0;
#     #      makeup3 = 5.0;
#     #      ratio0 = 5.0;
#     #      ratio1 = 3.0;
#     #      ratio2 = 3.0;
#     #      ratio3 = 4.0;
#     #      release-time0 = 300.0;
#     #      release-time1 = 200.0;
#     #      release-time2 = 150.0;
#     #      release-time3 = 120.0;
#     #      split-frequency1 = 250.0;
#     #      split-frequency2 = 1250.0;
#     #      split-frequency3 = 5000.0;
#     #    };
#   
#     #    "com/github/wwmm/easyeffects/streamoutputs/stereotools/0" = {
#     #      stereo-base = 0.30000000000000004;
#     #    };
#   
#     #    "org/blueman/general" = {
#     #      window-properties = [ 626 350 0 0 ];
#     #    };
#   
#     #    "org/fedoraproject/FirewallConfig" = {
#     #      show-active-bindings = true;
#     #      show-ipsets = true;
#     #    };
#   
#     #    "org/gnome/desktop/interface" = {
#     #      color-scheme = "prefer-dark";
#     #      cursor-size = 24;
#     #      cursor-theme = "Capitaine Cursors (Gruvbox)";
#     #      font-antialiasing = "rgba";
#     #      font-hinting = "full";
#     #      font-name = "DejaVuSansM Nerd Font 10";
#     #      gtk-theme = "Gruvbox-Material-Dark";
#     #      icon-theme = "Gruvbox-Material-Dark";
#     #    };
#   
#     #    "org/gnome/evince/default" = {
#     #      continuous = true;
#     #      dual-page = false;
#     #      dual-page-odd-left = true;
#     #      enable-spellchecking = true;
#     #      fullscreen = false;
#     #      inverted-colors = false;
#     #      show-sidebar = true;
#     #      sidebar-page = "thumbnails";
#     #      sidebar-size = 132;
#     #      sizing-mode = "automatic";
#     #      window-ratio = mkTuple [ 1.5686274509803921 1.3156565656565657 ];
#     #      zoom = 0.7604619115431094;
#     #    };
#   
#     #    "org/gnome/nm-applet/eap/020c5b3f-6ec8-44c0-b9e7-7cb714fac358" = {
#     #      ignore-ca-cert = false;
#     #      ignore-phase2-ca-cert = false;
#     #    };
#   
#     #    "org/gnome/nm-applet/eap/0414f4f2-5a2e-489d-8376-cae585a7dc03" = {
#     #      ignore-ca-cert = false;
#     #      ignore-phase2-ca-cert = false;
#     #    };
#   
#     #    "org/gnome/nm-applet/eap/083da7b6-4e4b-377e-8078-94b1ffbcc968" = {
#     #      ignore-ca-cert = false;
#     #      ignore-phase2-ca-cert = false;
#     #    };
#   
#     #    "org/gnome/nm-applet/eap/15af504c-99af-4277-b251-8e097dad39ee" = {
#     #      ignore-ca-cert = false;
#     #      ignore-phase2-ca-cert = false;
#     #    };
#   
#     #    "org/gnome/nm-applet/eap/242b4684-3d9a-40b6-8374-dcde1bccb6b7" = {
#     #      ignore-ca-cert = true;
#     #      ignore-phase2-ca-cert = false;
#     #    };
#   
#     #    "org/gnome/nm-applet/eap/24ab174b-7b43-4bb4-af16-4ac3dbe6a870" = {
#     #      ignore-ca-cert = false;
#     #      ignore-phase2-ca-cert = false;
#     #    };
#   
#     #    "org/gnome/nm-applet/eap/28be9b2e-1494-4914-a3e6-edf8e66e0f35" = {
#     #      ignore-ca-cert = false;
#     #      ignore-phase2-ca-cert = false;
#     #    };
#   
#     #    "org/gnome/nm-applet/eap/330cc811-8c3d-481b-9348-952c68724033" = {
#     #      ignore-ca-cert = false;
#     #      ignore-phase2-ca-cert = false;
#     #    };
#   
#     #    "org/gnome/nm-applet/eap/3f0c3b3a-a358-47ca-a901-eae5803ef9cf" = {
#     #      ignore-ca-cert = false;
#     #      ignore-phase2-ca-cert = false;
#     #    };
#   
#     #    "org/gnome/nm-applet/eap/4bb4bde5-50e2-4db9-980d-f717aec23080" = {
#     #      ignore-ca-cert = false;
#     #      ignore-phase2-ca-cert = false;
#     #    };
#   
#     #    "org/gnome/nm-applet/eap/6a34cb9a-1cc0-4706-be20-c346b5a307dd" = {
#     #      ignore-ca-cert = false;
#     #      ignore-phase2-ca-cert = false;
#     #    };
#   
#     #    "org/gnome/nm-applet/eap/73f2044e-59c7-4fe8-a736-b5dc2ecfcc2a" = {
#     #      ignore-ca-cert = false;
#     #      ignore-phase2-ca-cert = false;
#     #    };
#   
#     #    "org/gnome/nm-applet/eap/75f1b51b-23f9-4386-bee6-d165484dc379" = {
#     #      ignore-ca-cert = false;
#     #      ignore-phase2-ca-cert = false;
#     #    };
#   
#     #    "org/gnome/nm-applet/eap/79873f2a-6c8c-4ce2-8767-212b13a459a0" = {
#     #      ignore-ca-cert = false;
#     #      ignore-phase2-ca-cert = false;
#     #    };
#   
#     #    "org/gnome/nm-applet/eap/9fb64690-e034-42e6-bd52-350c78110172" = {
#     #      ignore-ca-cert = false;
#     #      ignore-phase2-ca-cert = false;
#     #    };
#   
#     #    "org/gnome/nm-applet/eap/bce2b0b6-5cc7-4b78-abff-2fa4153a6871" = {
#     #      ignore-ca-cert = false;
#     #      ignore-phase2-ca-cert = false;
#     #    };
#   
#     #    "org/gnome/nm-applet/eap/bfd58f47-ff91-4ca8-9394-e7788d1ac4ee" = {
#     #      ignore-ca-cert = false;
#     #      ignore-phase2-ca-cert = false;
#     #    };
#   
#     #    "org/gnome/nm-applet/eap/d02e93ec-a656-4a3b-828a-276ca2f5e8a2" = {
#     #      ignore-ca-cert = false;
#     #      ignore-phase2-ca-cert = false;
#     #    };
#   
#     #    "org/gnome/nm-applet/eap/d9e8ef82-7db8-46cc-a03e-a5c1f6afe738" = {
#     #      ignore-ca-cert = false;
#     #      ignore-phase2-ca-cert = false;
#     #    };
#   
#     #    "org/gnome/nm-applet/eap/da6ae64d-9d77-45c5-868e-617130101f96" = {
#     #      ignore-ca-cert = false;
#     #      ignore-phase2-ca-cert = false;
#     #    };
#   
#     #    "org/gnome/nm-applet/eap/dd7c670a-1bc0-3015-b7cb-b09e496da52b" = {
#     #      ignore-ca-cert = false;
#     #      ignore-phase2-ca-cert = false;
#     #    };
#   
#     #    "org/gnome/nm-applet/eap/e8b8f11e-0408-4924-942f-887dba125d6a" = {
#     #      ignore-ca-cert = false;
#     #      ignore-phase2-ca-cert = false;
#     #    };
#   
#     #    "org/gnome/nm-applet/eap/f9915a1d-fb76-411a-95df-9bb1970c6070" = {
#     #      ignore-ca-cert = true;
#     #      ignore-phase2-ca-cert = false;
#     #    };
#   
#     #    "org/gtk/gtk4/settings/file-chooser" = {
#     #      date-format = "regular";
#     #      location-mode = "path-bar";
#     #      show-hidden = false;
#     #      sidebar-width = 140;
#     #      sort-column = "name";
#     #      sort-directories-first = true;
#     #      sort-order = "ascending";
#     #      type-format = "category";
#     #      view-type = "list";
#     #      window-size = mkTuple [ 871 372 ];
#     #    };
#   
#     #    "org/gtk/settings/file-chooser" = {
#     #      date-format = "regular";
#     #      location-mode = "path-bar";
#     #      show-hidden = false;
#     #      show-size-column = true;
#     #      show-type-column = true;
#     #      sidebar-width = 189;
#     #      sort-column = "name";
#     #      sort-directories-first = false;
#     #      sort-order = "descending";
#     #      type-format = "category";
#     #      window-position = mkTuple [ 0 0 ];
#     #      window-size = mkTuple [ 1637 913 ];
#     #    };
#   
#     #  };
#   
#   }
