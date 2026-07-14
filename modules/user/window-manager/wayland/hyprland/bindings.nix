{ config, pkgs, ... }:
{
  config.wayland.windowManager.hyprland.extraConfig = ''

-- Controls
hl.bind("SUPER + Q",                        hl.dsp.exit())
hl.bind("SUPER + C",                        hl.dsp.window.close())
hl.bind("SUPER + F",                        hl.dsp.window.float({ action = "toggle" }))
hl.bind("SUPER + SHIFT + F",                hl.dsp.window.fullscreen({ action = "toggle" }))

-- Tools
hl.bind("SUPER + RETURN",                   hl.dsp.exec_cmd("${pkgs.kitty}/bin/kitty"))
hl.bind("SUPER + R",                        hl.dsp.exec_cmd("${pkgs.fuzzel}/bin/fuzzel"))
hl.bind("SUPER + PRINT",                    hl.dsp.exec_cmd("${pkgs.grim}/bin/grim"))
hl.bind("SUPER + SHIFT + PRINT",            hl.dsp.exec_cmd("${pkgs.grim}/bin/grim -g \"(${pkgs.slurp}/bin/slurp -w 0)\""))

-- Movements
hl.bind("SUPER + H",                        hl.dsp.focus({ direction = "left" }))
hl.bind("SUPER + J",                        hl.dsp.focus({ direction = "down" }))
hl.bind("SUPER + K",                        hl.dsp.focus({ direction = "up" }))
hl.bind("SUPER + L",                        hl.dsp.focus({ direction = "right" }))
hl.bind("SUPER + SHIFT + H",                hl.dsp.window.move({ direction = "left" }))
hl.bind("SUPER + SHIFT + J",                hl.dsp.window.move({ direction = "down" }))
hl.bind("SUPER + SHIFT + K",                hl.dsp.window.move({ direction = "up" }))
hl.bind("SUPER + SHIFT + L",                hl.dsp.window.move({ direction = "right" }))

-- Workspaces
hl.bind("SUPER + X",                        hl.dsp.workspace.move({ monitor = "+1" }))

for i = 1, 10 do
    local key = i % 10
    hl.bind("SUPER + " .. key,              hl.dsp.focus({ workspace = i }))
    hl.bind("SUPER + SHIFT + " .. key,      hl.dsp.window.move({ workspace = i }))
end

-- Move/resize windows with mouse drag
hl.bind("SUPER + mouse:272",                hl.dsp.window.drag(),       { mouse = true })
hl.bind("SUPER + mouse:273",                hl.dsp.window.resize(),     { mouse = true })

-- Resize windows with keys
hl.bind(
    "ALT + H",
    hl.dsp.window.resize({ x = -10, y = 0, relative = true }),
    { repeating = true }
)
hl.bind(
    "ALT + L",
    hl.dsp.window.resize({ x = 10, y = 0, relative = true }),
    { repeating = true }
)
hl.bind(
    "ALT + J",
    hl.dsp.window.resize({ x = 0, y = -10, relative = true }),
    { repeating = true }
)
hl.bind(
    "ALT + K",
    hl.dsp.window.resize({ x = 0, y = 10, relative = true }),
    { repeating = true }
)

-- Multimedia
hl.bind("XF86AudioRaiseVolume",             hl.dsp.exec_cmd("${pkgs.wireplumber}/bin/wpctl set-volume -l 1.5 @DEFAULT_AUDIO_SINK@ 5%+", { locked = true, repeating = true }))
hl.bind("XF86AudioLowerVolume",             hl.dsp.exec_cmd("${pkgs.wireplumber}/bin/wpctl set-volume -l 1.5 @DEFAULT_AUDIO_SINK@ 5%-", { locked = true, repeating = true }))
hl.bind("XF86AudioMute",                    hl.dsp.exec_cmd("${pkgs.wireplumber}/bin/wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle", { locked = true, repeating = true }))
hl.bind("XF86MonBrightnessUp",              hl.dsp.exec_cmd("${pkgs.brightnessctl}/bin/brightnessctl -e4 -n2 set 5%+", { locked = true, repeating = true }))
hl.bind("XF86MonBrightnessDown",            hl.dsp.exec_cmd("${pkgs.brightnessctl}/bin/brightnessctl -e4 -n2 set 5%-", { locked = true, repeating = true }))
  '';
}
