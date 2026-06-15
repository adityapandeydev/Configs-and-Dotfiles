{ config, pkgs, ... }:

{
  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;
    
    extraConfig = ''
      # ==================================================
      # VARIABLES
      # ==================================================
      $mainMod = SUPER

      $terminal = ~/.config/Scripts/ghostty-launch.sh
      $fileManager = dolphin
      $browser = zen-browser
      $menu = ~/.config/rofi/launchers/type-3/launcher.sh

      # ==================================================
      # STARTUP
      # ==================================================
      exec-once = awww-daemon
      exec-once = ~/.config/Scripts/wallpaper-init.sh
      exec-once = wayle panel start
      exec-once = nm-applet --indicator
      exec-once = blueman-applet
      
      exec-once = /usr/lib/polkit-kde-authentication-agent-1
      
      exec-once = wl-paste --type text --watch cliphist store
      exec-once = wl-paste --type image --watch cliphist store
      
      exec-once = hypridle
      
      exec-once = [workspace 2 silent] zen-browser
      exec-once = [workspace 3 silent] code

      # ==================================================
      # MONITORS
      # ==================================================
      monitor = eDP-1,1920x1080@144,0x0,1.25

      # ==================================================
      # GENERAL & DECORATION
      # ==================================================
      general {
          gaps_in = 2
          gaps_out = 3
          border_size = 0
      }

      decoration {
          rounding = 2

          blur {
              enabled = true
              size = 4
              passes = 2
          }
      }

      input {
          numlock_by_default = true
      }

      # ==================================================
      # RULES
      # ==================================================
      windowrule {
          name = my-ghostty-rule
          match:class = ^(com\.mitchellh\.ghostty\.float)$
          float = on
          center = on
          size = 1200 700
      }

      layerrule {
          name = rofi-blur
          match:namespace = rofi
          blur = on
      }

      animations {
          enabled = true

          bezier = bounce, 0.5, 1.5, 0.5, 1

          animation = windows, 1, 5, bounce, popin 50%
          animation = windowsOut, 1, 4, default, popin 80%
          animation = fade, 1, 4, default
          animation = workspaces, 1, 5, bounce, slide
      }

      dwindle {
          preserve_split = true
      }

      # ==================================================
      # BINDS
      # ==================================================
      binds {
          workspace_back_and_forth = true
          allow_workspace_cycles = true
      }

      # Switch workspaces
      bind = $mainMod, 1, workspace, 1
      bind = $mainMod, 2, workspace, 2
      bind = $mainMod, 3, workspace, 3
      bind = $mainMod, 4, workspace, 4
      bind = $mainMod, 5, workspace, 5
      bind = $mainMod, 6, workspace, 6
      bind = $mainMod, 7, workspace, 7
      bind = $mainMod, 8, workspace, 8
      bind = $mainMod, 9, workspace, 9
      bind = $mainMod, 0, workspace, 10

      # Move active window to workspace
      bind = $mainMod SHIFT, 1, movetoworkspace, 1
      bind = $mainMod SHIFT, 2, movetoworkspace, 2
      bind = $mainMod SHIFT, 3, movetoworkspace, 3
      bind = $mainMod SHIFT, 4, movetoworkspace, 4
      bind = $mainMod SHIFT, 5, movetoworkspace, 5
      bind = $mainMod SHIFT, 6, movetoworkspace, 6
      bind = $mainMod SHIFT, 7, movetoworkspace, 7
      bind = $mainMod SHIFT, 8, movetoworkspace, 8
      bind = $mainMod SHIFT, 9, movetoworkspace, 9
      bind = $mainMod SHIFT, 0, movetoworkspace, 10

      workspace = 2, persistent:true
      workspace = 3, persistent:true
      bindel = ALT, TAB, workspace, previous

      bind = $mainMod, RETURN, exec, $terminal
      bind = $mainMod, E, exec, $fileManager
      bind = $mainMod, B, exec, $browser
      bind = $mainMod, R, exec, $menu

      bind = $mainMod, F, fullscreen
      bind = $mainMod, Q, killactive,
      bind = $mainMod, T, exec, ~/.config/Scripts/toggle-float.sh
      bind = $mainMod, M, exec, hyprlock

      bind = $mainMod, H, movefocus, l
      bind = $mainMod, J, movefocus, d
      bind = $mainMod, K, movefocus, u
      bind = $mainMod, L, movefocus, r
      bindel = $mainMod, TAB, cyclenext
      bindel = $mainMod SHIFT, TAB, cyclenext, prev

      bind = $mainMod SHIFT, H, movewindow, l
      bind = $mainMod SHIFT, J, movewindow, d
      bind = $mainMod SHIFT, K, movewindow, u
      bind = $mainMod SHIFT, L, movewindow, r
      bindm = $mainMod, mouse:272, movewindow

      bindel = $mainMod CTRL, H, resizeactive, -50 0
      bindel = $mainMod CTRL, L, resizeactive, 50 0
      bindel = $mainMod CTRL, K, resizeactive, 0 -50
      bindel = $mainMod CTRL, J, resizeactive, 0 50
      bindm = $mainMod, mouse:273, resizewindow

      bindel = , XF86AudioRaiseVolume, exec, wpctl set-volume -l 1.5 @DEFAULT_AUDIO_SINK@ 5%+
      bindel = , XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-
      bindl  = , XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle
      bindl  = , XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle

      bindel = , XF86MonBrightnessUp, exec, brightnessctl set 5%+
      bindel = , XF86MonBrightnessDown, exec, brightnessctl set 5%-

      bind = $mainMod, C, exec, cliphist list | rofi -dmenu | cliphist decode | wl-copy

      bind = , PRINT, exec, grim ~/Pictures/Screenshots/$(date +'%Y-%m-%d_%H-%M-%S').png && notify-send "Screenshot" "Saved to ~/Pictures/Screenshots"
      bind = SHIFT, PRINT, exec, grim -g "$(slurp)" ~/Pictures/Screenshots/$(date +'%Y-%m-%d_%H-%M-%S').png && notify-send "Screenshot" "Area screenshot saved"

      bindel = $mainMod, code:34, exec, ~/.config/Scripts/wallpaper-prev.sh
      bindel = $mainMod, code:35, exec, ~/.config/Scripts/wallpaper-next.sh

      bind = $mainMod, G, exec, ~/.config/Scripts/lazygit-smart.sh
      bind = $mainMod, S, togglespecialworkspace, magic
      bind = $mainMod SHIFT, S, movetoworkspace, special:magic
      bind = $mainMod, P, pin
      bind = $mainMod, V, layoutmsg, togglesplit
      bind = $mainMod SHIFT, C, exec, code
      bind = $mainMod SHIFT, Z, exec, zed
      bind = $mainMod SHIFT, B, exec, killall wayle || wayle panel start
    '';
  };

  # Hypridle
  services.hypridle = {
    enable = true;
    settings = {
      general = {
        lock_cmd = "pidof hyprlock || hyprlock";
        before_sleep_cmd = "pidof hyprlock || hyprlock";
        after_sleep_cmd = "hyprctl dispatch dpms on";
      };
      listener = [
        {
          timeout = 300;
          on-timeout = "hyprlock";
        }
        {
          timeout = 330;
          on-timeout = "systemctl suspend";
        }
      ];
    };
  };

  # Hyprlock
  programs.hyprlock = {
    enable = true;
    settings = {
      general = {
        no_fade_in = false;
        grace = 0;
        disable_loading_bar = true;
        hide_cursor = true;
        ignore_empty_input = true;
      };

      background = [{
        monitor = "";
        path = "/home/adityapandey/Pictures/Wallpapers/076.png";
        blur_passes = 0;
        blur_size = 0;
        contrast = 1.0;
        brightness = 1.0;
        vibrancy = 0.0;
      }];

      shape = [
        {
          monitor = "";
          size = "520, 1080";
          color = "rgba(15,15,20,0.25)";
          rounding = 0;
          border_size = 0;
          position = "0, 0";
          halign = "left";
          valign = "center";
        }
        {
          monitor = "";
          size = "340, 54";
          color = "rgba(255,255,255,0.15)";
          rounding = 27;
          border_size = 0;
          position = "110, -120";
          halign = "left";
          valign = "center";
        }
      ];

      label = [
        {
          monitor = "";
          text = "cmd[update:1000] date +\"%H:%M\"";
          color = "rgba(220,220,220,0.85)";
          font_size = 42;
          font_family = "JetBrainsMono Nerd Font";
          position = "115, 190";
          halign = "left";
          valign = "center";
        }
        {
          monitor = "";
          text = "cmd[update:60000] date +\"%A, %B %d\"";
          color = "rgba(220,220,220,0.75)";
          font_size = 18;
          font_family = "JetBrainsMono Nerd Font";
          position = "115, 125";
          halign = "left";
          valign = "center";
        }
        {
          monitor = "";
          text = " $USER";
          color = "rgba(235,235,235,0.90)";
          font_size = 16;
          font_family = "JetBrainsMono Nerd Font";
          position = "190, -120";
          halign = "left";
          valign = "center";
        }
      ];

      input-field = [{
        monitor = "";
        size = "340, 54";
        outline_thickness = 0;
        outer_color = "rgba(0,0,0,0)";
        inner_color = "rgba(255,255,255,0.10)";
        font_color = "rgb(235,235,235)";
        fade_on_empty = false;
        font_family = "JetBrainsMono Nerd Font";
        hide_input = false;
        placeholder_text = "🔒 Password";
        rounding = 27;
        dots_center = true;
        dots_size = 0.35;
        dots_spacing = 0.35;
        position = "110, -195";
        halign = "left";
        valign = "center";
      }];
    };
  };
}
