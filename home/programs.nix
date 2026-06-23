{ config, pkgs, ... }:

{
  xdg.configFile."fastfetch" = {
    source = ../fastfetch;
    recursive = true;
  };

  xdg.configFile."wayle" = {
    source = ../wayle;
    recursive = true;
  };

  xdg.configFile."btop" = {
    source = ../btop;
    recursive = true;
  };

  xdg.configFile."nvim" = {
    source = ../nvim;
    recursive = true;
  };

  xdg.configFile."rofi" = {
    source = ../rofi;
    recursive = true;
  };

  xdg.configFile."ghostty" = {
    source = ../terminal;
    recursive = true;
  };
}
