{ inputs, pkgs, ...}:

{
  import = [
    ./../system/default.nix
    ./../profiles/default.nix
    ./../hosts/default.nix

    inputs.home-manager.nixosModules.default
  ];

  ### System Settings ###

  sys.gpu.vendor = "nvidia";
  sys.sway.enable = true;
  sys.theme = "catppuccin";
  sys.host = "desktop";
  sys.user = "jonas";
  sys.i18n.locale = "en_US.UTF-8";
  sys.xkb.layout = "us";
  sys.time = "Europe/Berlin";

  # ...

  ### Custom Configuration ###

  hardware.opentabletdriver = {
    enable = true;
    daemon.enable = true;
  };

  environment.systemPackages = with pkgs; [
    mpv 
    imv 
  ];

  # ...
}
