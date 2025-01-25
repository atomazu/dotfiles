{ pkgs, ... }:

{
  wayland.windowManager.sway = {
    enable = true;
    
    wrapperFeatures.gtk = true;
    wrapperFeatures.base = true;
    extraOptions = ["--unsupported-gpu"];
   
    # TODO Move device specific options to host specific configuration.
    # That includes the 'output' section and '--unsupported-gpu' since it's
    # hardware specific.
    config = {
      menu = "wmenu-run -b";
      terminal = "foot";
      modifier = "Mod4";
      output = {
        DP-3 = {
          mode = "2560x1440@240hz";
          pos = "1440 0";
        };
        DP-4 = {
          mode = "2560x1440@144hz";
          pos = "0 0";
          transform = "270";
        };
      };
    };
  };
}
