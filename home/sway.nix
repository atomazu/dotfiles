{ pkgs, ... }:

{
  wayland.windowManager.sway = {
    enable = true;
    
    wrapperFeatures.gtk = true;
    wrapperFeatures.base = true;
    extraOptions = ["--unsupported-gpu"];
   
    config = {
      output = {
        DP-3 = {
          mode = "2560x1440@240hz";
          pos = "1440 -1280";
          # bg = "~/.nixos/assets/wallpaper.jpg";
        };
        DP-4 = {
          mode = "2560x1440@144hz";
          pos = "0 0";
          # bg = "~/.nixos/assets/wallpaper.jpg";
          transform = "270";
        };
      };
    };
  };
}
