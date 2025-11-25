{ ... }:
{
  config.wayland.windowManager.hyprland.settings.windowrule = [
    # Console
    "workspace 10, match:class (Alacritty)(.*)"
    "workspace 10, match:class (kitty)(.*)"

    # Web browsers
    "workspace 1, match:class (floorp)(.*)"
    "workspace 1, match:class (firefox)(.*)"
    "workspace 1, match:class (Librewolf)(.*)"

    # File browsers
    "workspace 2, match:class (thunar)(.*)"

    # Readers
    "workspace 3, match:class (obsidian)(.*)"
    "workspace 3, match:class (Zotero)(.*)"
    "float on, match:class (Zotero)(.*)"

    # Multi-media
    "workspace 4, match:class (Slack)(.*)"
    "float on, match:class (Slack)(.*)"

    "workspace 4, match:class (discord)(.*)"
    "float on, match:class (discord)(.*)"

    "workspace 4, match:class (zoom)(.*)"
    "float on, match:class (zoom)(.*)"

    "workspace 4, match:class (Element)(.*)"
    "float on, match:class (Element)(.*)"

    # Clients & daemon
    "workspace 5, match:class (blueman-manager)(.*)"
    "float on, match:class (blueman-manager)(.*)"

    "workspace 5, match:class (.blueman-manager-wrapped)(.*)"
    "float on, match:class (.blueman-manager-wrapped)(.*)"

    "workspace 5, match:class (Cisco AnyConnect Secure Mobility Client)(.*)"
    "float on, match:class (Cisco AnyConnect Secure Mobility Client)(.*)"

    "workspace 5, match:class (com.cisco.anyconnect.gui)(.*)"
    "float on, match:class (com.cisco.anyconnect.gui)(.*)"

    "workspace 5, match:class (MEGAsync)(.*)"
    "float on, match:class (MEGAsync)(.*)"

    "workspace 5, match:class (org.cryptomator.launcher.Cryptomator\\$MainApp)(.*)"
    "float on, match:class (org.cryptomator.launcher.Cryptomator\\$MainApp)(.*)"

    # Free-floating
    "float on, match:class (udiskie)(.*)"
    "float on, match:class (swayimg)(.*)"
    "float on, match:class (imv)(.*)"
    "float on, match:class (Matplotlib)(.*)"
    "float on, match:class (nm-openconnect-auth-dialog)(.*)"
    "float on, match:class (nm-connection-editor)(.*)"
    "float on, match:title (Extension: (Bitwarden - Free Password Manager) - Bitwarden — Mozilla Firefox)(.*)"
  ];
}
