{ pkgs, inputs, ... }:

{
  home.packages = with pkgs; [
    # Development
    jdk
    go
    python312
    rustup
    rustc
    gcc
    nodejs
    gleam
    zig_0_12

    # Databases
    postgresql
    mysql80

    # Applications
    discord
    vscode-fhs
    zed-editor
    inputs.zen-browser.packages."${pkgs.system}".default
    protonvpn-gui
    signal-desktop
    vlc
    gimp
    floorp

    # Utilities
    btop
    fastfetch
    lazygit
    neovim
    rofi-wayland
    lsd
    bat
    fzf
    yazi
    unzip
    overskride
    nixd
    zinit
    pywal

    # Wayland tools
    wl-clipboard
    cliphist
    networkmanagerapplet
    blueman
    brightnessctl
    wireplumber
    swww # Placeholder for awww-daemon until we package it
  ];
}
