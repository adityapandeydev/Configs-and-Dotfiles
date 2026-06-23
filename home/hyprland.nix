{ config, pkgs, ... }:

{
  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;
    systemd.enable = true;
    
    # We no longer use extraConfig, as we are natively mapping the Arch directory
  };

  # Source the entire Hyprland folder directly from the workspace
  xdg.configFile."hypr" = {
    source = ../Hyprland;
    recursive = true;
  };

  # We also need to map the scripts folder
  xdg.configFile."hypr/scripts" = {
    source = ../Scripts;
    recursive = true;
  };
}
