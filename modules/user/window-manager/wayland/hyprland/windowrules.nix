{ ... }:
{
  config.wayland.windowManager.hyprland.settings.windowrulev2 = [
    # Console
    "workspace 10, class:^(Alacritty)(.*)$"
    "workspace 10, class:^(kitty)(.*)$"

    # Web browsers
    "workspace 1, class:^(floorp)(.*)$"
    "workspace 1, class:^(firefox)(.*)$"
    "workspace 1, class:^(Librewolf)(.*)$"

    # File browsers
    "workspace 2, class:^(thunar)(.*)$"

    # Readers
    "workspace 3, class:^(obsidian)(.*)$"
    "workspace 3, class:^(Zotero)(.*)$"
    "float, class:Zotero"

    # Multi-media
    "workspace 4, class:^(Slack)(.*)$"
    "float, class:^(Slack)(.*)$"

    "workspace 4, class:^(discord)(.*)$"
    "float, class:^(discord)(.*)$"

    "workspace 4, class:^(zoom)(.*)$"
    "float, class:^(zoom)(.*)$"

    "workspace 4, class:^(Element)(.*)$"
    "float, class:^(Element)(.*)$"

    # Clients & daemon
    "workspace 5, class:^(blueman-manager)(.*)$"
    "float, class:^(blueman-manager)(.*)$"

    "workspace 5, class:^(.blueman-manager-wrapped)(.*)$"
    "float, class:^(.blueman-manager-wrapped)(.*)$"

    "workspace 5, class:^(Cisco AnyConnect Secure Mobility Client)(.*)$"
    "float, class:^(Cisco AnyConnect Secure Mobility Client)(.*)$"

    "workspace 5, class:^(com.cisco.anyconnect.gui)(.*)$"
    "float, class:^(com.cisco.anyconnect.gui)(.*)$"

    "workspace 5, class:^(MEGAsync)(.*)$"
    "float, class:^(MEGAsync)(.*)$"

    "workspace 5, class:^(org.cryptomator.launcher.Cryptomator\\$MainApp)(.*)$"
    "float, class:^(org.cryptomator.launcher.Cryptomator\\$MainApp)(.*)$"

    # Free-floating
    "float, class:^(udiskie)(.*)$"
    "float, class:^(swayimg)(.*)$"
    "float, class:^(imv)(.*)$"
    "float, class:^(Matplotlib)(.*)$"
    "float, class:^(nm-openconnect-auth-dialog)(.*)$"
    "float, class:^(nm-connection-editor)(.*)$"
    "float, title:^(Extension: (Bitwarden - Free Password Manager) - Bitwarden — Mozilla Firefox)(.*)$"
  ];
}
