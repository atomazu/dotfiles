{ config, pkgs, inputs, ... }:

{
  imports = [
      ./hardware-configuration.nix
    ];
  
  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

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

  environment.systemPackages = with pkgs; [];

  home-manager = {
    extraSpecialArgs = { inherit inputs; };
    useGlobalPkgs = true;
    useUserPackages = true;
    users."jonas" = import ./home.nix;
  };

  fonts.enableDefaultPackages = true;
  fonts.packages = with pkgs; [
    nerd-fonts.fira-code
  ];

  services = {
    xserver = {
      xkb = {
        layout = "us";
        variant = "";
      };

      videoDrivers = ["nvidia"];
    };
    
    openssh = {
      enable = true;
    };

    # displayManager.ly.enable = true;
    # gnome.gnome-keyring.enable = true;
    # blueman.enable = true;

    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;
    };
  };

  # security.polkit.enable = true;
  security.pam.loginLimits = [
    {
      domain = "@users";
      item = "rtprio";
      type = "-";
      value = 1;
    }
  ];

  users.users.jonas = {
    isNormalUser = true;
    description = "Jonas";
    extraGroups = [ "networkmanager" "wheel" ];
  };

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

  hardware = {
    graphics = {
      enable = true;
    };

    # bluetooth = {
    #   enable = true;
    #   powerOnBoot = true;
    # };

    nvidia = {
      modesetting.enable = true;
      powerManagement.enable = false;
      powerManagement.finegrained = false;

      open = false;
      nvidiaSettings = false;
      package = config.boot.kernelPackages.nvidiaPackages.beta;
    };
  };

  system.stateVersion = "24.11";
}
