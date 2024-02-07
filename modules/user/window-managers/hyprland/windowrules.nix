{ ... }:
{
  config.wayland.windowManager.hyprland.settings.windowrulev2 = [
    # Console
    "workspace 10, class:^(Alacritty)(.*)$"

    # Web browsers
    "workspace 1, class:^(floorp)(.*)$"
    "workspace 1, class:^(firefox)(.*)$"
    "workspace 1, class:^(Librewolf)(.*)$"

    # File browsers
    "workspace 2, class:^(thunar)(.*)$"

    # Readers
    "workspace 3, class:^(Zotero)(.*)$"

    # Multi-media
    "workspace 4, class:^(Slack)(.*)$"
    "workspace 4, class:^(discord)(.*)$"
    "workspace 4, class:^(zoom)(.*)$"
    "float, class:^(Slack)(.*)$"
    "float, class:^(discord)(.*)$"
    "float, class:^(zoom)(.*)$"

    # Clients & daemon
    "workspace 5, class:^(Cisco AnyConnect Secure Mobility Client)(.*)$"
    "workspace 5, class:^(com.cisco.anyconnect.gui)(.*)$"
    "workspace 6, class:^(blueman-manager)(.*)$"
    "workspace 6, class:^(org.cryptomator.launcher.Cryptomator\$MainApp)(.*)$"
    "workspace 6, class:^(nz.co.mega.megasync)(.*)$"
    "float, class:^(blueman-manager)(.*)$"
    "float, class:^(nm-connection-editor)(.*)$"
    "float, class:^(com.cisco.anyconnect.gui)(.*)$"
    "float, class:^(Cisco AnyConnect Secure Mobility Client)(.*)$"
    "float, class:^(org.cryptomator.launcher.Cryptomator\$MainApp)(.*)$"
    "float, class:^(nz.co.mega.megasync)(.*)$"

    # Free-floating
    "float, class:^(swayimg)(.*)$"
    "float, class:^(imv)(.*)$"
    "float, class:^(Matplotlib)(.*)$"
  ];
}
