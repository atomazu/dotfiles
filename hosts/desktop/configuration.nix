{ config, pkgs, inputs, ... }:

{
  imports = [
      ./hardware-configuration.nix
    ];
  
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "desktop"; 
  networking.networkmanager.enable = true;

  time.timeZone = "Europe/Berlin";

  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # No need to be imported since it's being provided by the flake.
  home-manager = {
    extraSpecialArgs = { inherit inputs; }; 
    users."jonas" = import ./home.nix;
  };

  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  services.openssh = {
    enable = true;
  };

  # services.displayManager.sddm.enable = true;
  # services.displayManager.sddm.wayland.enable = true;
  # services.gnome.gnome-keyring.enable = true;
  services.xserver.videoDrivers = ["nvidia"];
  # services.pipewire = {
  #   enable = true;
  #   alsa.enable = true;
  #   alsa.support32Bit = true;
  #   pulse.enable = true;
  #   jack.enable = true;
  # };

  # security.rtkit.enable = true;
  # security.polkit.enable = true;
  # security.pam.services.swaylock = {
  #   text = "auth include login"; 
  # };

  users.users.jonas = {
    isNormalUser = true;
    description = "Jonas";
    extraGroups = [ "networkmanager" "wheel" ];
  };

  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [];
  
  # programs.sway = {
  #   enable = true;
  #   wrapperFeatures.gtk = true;
  #   wrapperFeatures.base = true;
  #   extraOptions = ["--unsupported-gpu"];
  #   extraPackages = with pkgs; [
  #     foot
  #     wmenu
  #     swaybg
  #     swaylock
  #     swayidle 
  #     mako
  #     wl-clipboard
  #   ];
  # };

  hardware.graphics = {
    enable = true;
  }; 

  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = false;
    powerManagement.finegrained = false;

    open = false;
    nvidiaSettings = false;
    package = config.boot.kernelPackages.nvidiaPackages.beta;
  };

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  system.stateVersion = "24.11";
}
