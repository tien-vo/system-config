{ config, ... }:
{
  config.wayland.windowManager.hyprland.extraConfig = ''
-- Console
hl.window_rule({ match = { class = "^(Alacritty)(.*)" }, workspace = 10 })
hl.window_rule({ match = { class = "^(kitty)(.*)" }, workspace = 10 })

-- Web browsers
hl.window_rule({ match = { class = "^(firefox)(.*)" }, workspace = 1 })
hl.window_rule({ match = { class = "^(floorp)(.*)" }, workspace = 1 })
hl.window_rule({ match = { class = "^(Librewolf)(.*)" }, workspace = 1 })

-- File browser
hl.window_rule({ match = { class = "^(thunar)(.*)" }, workspace = 2 })

-- Readers
hl.window_rule({ match = { class = "^(obsidian)(.*)" }, workspace = 3 })
hl.window_rule({ match = { class = "^(Zotero)(.*)" }, workspace = 3 })

-- Multi-media
hl.window_rule({ match = { class = "^(Slack)(.*)" }, workspace = 4, float = true })
hl.window_rule({ match = { class = "^(discord)(.*)" }, workspace = 4, float = true })
hl.window_rule({ match = { class = "^(zoom)(.*)" }, workspace = 4, float = true })
hl.window_rule({ match = { class = "^(Element)(.*)" }, workspace = 4, float = true })

-- Clients & daemon
hl.window_rule({ match = { class = "^(blueman-manager)(.*)" }, workspace = 5, float = true })
hl.window_rule({ match = { class = "^(Cisco Anyconnect Secure Mobility Client)(.*)" }, workspace = 5, float = true })
hl.window_rule({ match = { class = "^(com.cisco.anyconnect.gui)(.*)" }, workspace = 5, float = true })
hl.window_rule({ match = { class = "^(MEGAsync)(.*)" }, workspace = 5, float = true })
hl.window_rule({ match = { class = "^(org.cryptomator.launcher.Cryptomator\\$MainApp)(.*)" }, workspace = 5, float = true })
hl.window_rule({ match = { class = "^(Filen)(.*)" }, workspace = 5, float = true })

-- Free-floating
hl.window_rule({ match = { class = "^(udiskie)(.*)" }, float = true })
hl.window_rule({ match = { class = "^(swayimg)(.*)" }, float = true })
hl.window_rule({ match = { class = "^(imv)(.*)" }, float = true })
hl.window_rule({ match = { class = "^(Matplotlib)(.*)" }, float = true })
hl.window_rule({ match = { class = "^(nm-openconnect-auth-dialog)(.*)" }, float = true })
hl.window_rule({ match = { title = "^(Extension: (Bitwarden - Free Password Manager) - Bitwarden — Mozilla Firefox)(.*)" }, float = true })
  '';
}
