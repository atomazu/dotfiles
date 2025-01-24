{ pkgs, ... }:

{
  programs.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
    wrapperFeatures.base = true;
    extraOptions = ["--unsupported-gpu"];
    xwayland.enable = true;
    extraPackages = with pkgs; [
      wmenu
      swaybg
      swaylock
      swayidle 
      mako
      wl-clipboard
      grim
      slurp
    ];
  };
  
  services.gnome.gnome-keyring.enable = true;
  security.polkit.enable = true;
  programs.uwsm = {
    enable = true;
    waylandCompositors = {
      sway = {
        prettyName = "Sway";
        comment = "Sway compositor managed by UWSM";
        binPath = "/run/current-system/sw/bin/sway";
      };
    };
  };
}
