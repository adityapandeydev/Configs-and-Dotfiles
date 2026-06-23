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
    zig

    # Databases
    postgresql
    mysql84

    # Applications
    discord
    vscode-fhs
    zed-editor
    inputs.zen-browser.packages."${pkgs.system}".default
    proton-vpn
    signal-desktop
    vlc
    gimp

    # Utilities
    btop
    fastfetch
    lazygit
    neovim
    rofi
    lsd
    bat
    fzf
    yazi
    unzip
    overskride
    nixd
    zinit

    # Wayland tools
    wl-clipboard
    cliphist
    networkmanagerapplet
    blueman
    brightnessctl
    wireplumber
    awww
    ghostty
    wayle
  ];
}
