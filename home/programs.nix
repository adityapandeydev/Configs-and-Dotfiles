{ config, pkgs, ... }:

{
  xdg.configFile."wayle/config.toml".text = ''
    [general]
    font-sans = "JetBrainsMono Nerd Font Mono"

    [bar]
    scale = 0.70
    layer = "top"

    [[bar.layout]]
    monitor = "*"
    show = true
    left = [
        "dashboard",
        "hyprland-workspaces",
        "weather",
        "notifications",
    ]
    center = ["clock"]
    right = [
        { name = "1", modules = [
        "bluetooth",
        "network",
    ] },
        { name = "2", modules = [
        "brightness",
        "volume",
        "microphone",
    ] },
        "battery",
    ]

    [styling.palette]
    bg = "#11111b"
    surface = "#181825"
    elevated = "#1e1e2e"
    fg = "#cdd6f4"
    fg-muted = "#bac2de"
    primary = "#b4befe"
    red = "#f38ba8"
    yellow = "#f9e2af"
    green = "#a6e3a1"
    blue = "#74c7ec"

    [modules.battery]
    border-color = "red"
    icon-bg-color = "red"
    label-color = "red"

    [modules.brightness]
    border-color = "green"
    icon-bg-color = "green"
    label-color = "green"
    scroll-up = "brightnessctl set 5%+"
    scroll-down = "brightnessctl set 5%-"

    [modules.cava]
    framerate = 144
    style = "wave"
    color = "green"

    [modules.clock]
    format = "%a %b %d %H:%M"
    right-click = ""

    [modules.dashboard]
    border-color = "red"
    icon-bg-color = "red"
    dropdown-lock-command = "hyprlock"
    dropdown-logout-command = "uwsm stop"

    [modules.hyprland-workspaces]
    min-workspace-count = 255
    display-mode = "icon"
    app-icons-show = true
    active-color = "#fab387"

    [modules.microphone]
    border-color = "#fab387"
    icon-bg-color = "#fab387"
    label-color = "#fab387"
    scroll-up = "wpctl set-volume -l 1.0 @DEFAULT_AUDIO_SOURCE@ 5%+"
    scroll-down = "wpctl set-volume @DEFAULT_AUDIO_SOURCE@ 5%-"

    [modules.network]
    border-color = "blue"
    icon-bg-color = "blue"
    label-color = "blue"

    [modules.netstat]
    border-color = "status-success"
    icon-bg-color = "green"
    label-color = "green"

    [modules.notifications]
    border-color = "blue"
    icon-bg-color = "blue"
    label-color = "blue"
    popup-duration = 3000

    [modules.ram]
    icon-bg-color = "yellow"
    label-color = "yellow"

    [modules.volume]
    border-color = "#fab387"
    icon-bg-color = "#fab387"
    label-color = "#fab387"
    scroll-up = "wpctl set-volume -l 1.5 @DEFAULT_AUDIO_SINK@ 5%+"
    scroll-down = "wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"

    [modules.weather]
    location = "Deoria"
    time-format = "24h"
    refresh-interval-seconds = 180
    border-color = "green"
    icon-bg-color = "green"
    label-color = "green"

    [modules.window-title]
    label-max-length = 20

    [wallpaper]
    engine-enabled = false
  '';

  xdg.configFile."ghostty/config".text = ''
    gtk-titlebar = false
    background-opacity = 0.5
    font-family = JetBrainsMono Nerd Font Mono
    theme = Catppuccin Mocha
  '';
}
