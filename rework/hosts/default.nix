{ inputs, config, pkgs, lib, ... }:

{
  ### Imports ###

  imports = [
    ./../system/default.nix
    ./../profiles/default.nix
  ];

  ### Options ###

  options.sys = {
    host = lib.mkOption {
      type = lib.types.str;
      description = "The hostname of the system";
    };

    user = lib.mkOption {
      type = lib.types.str;
      description = "The primary user of the system";
    };

    theme = lib.mkOption {
      type = lib.types.str;
      default = "adwaita";
      description = "The overall system theme";
    };

    gpu.vendor = lib.mkOption {
      type = lib.types.str;
      default = "";
      description = "GPU vendor";
    };

    sway.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable Sway Window Manager";
    };

    i18n.locale = lib.mkOption {
      type = lib.types.str;
      default = "en_US.UTF-8";
      description = "System locale.";
    };

    xkb.layout = lib.mkOption {
      type = lib.types.str;
      default = "us";
      description = "System keyboard layout.";
    };

    time = lib.mkOption {
      type = lib.types.str;
      default = "Europe/Berlin";
      description = "System time.";
    };
  };

  ### Configuration ###

  config = {
    nixpkgs.config.allowUnfree = true;
    nix.settings.experimental-features = [ "nix-command" "flakes" ];

    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;

    networking.hostName = "${config.system.host}"; 
    networking.networkmanager.enable = true;

    time.timeZone = "${config.system.time}";

    i18n.defaultLocale = "${config.system.locale}";
    i18n.extraLocaleSettings = {
      LC_ADDRESS = "${config.system.locale}";
      LC_IDENTIFICATION = "${config.system.locale}";
      LC_MEASUREMENT = "${config.system.locale}";
      LC_MONETARY = "${config.system.locale}";
      LC_NAME = "${config.system.locale}";
      LC_NUMERIC = "${config.system.locale}";
      LC_PAPER = "";
      LC_TELEPHONE = "${config.system.locale}";
      LC_TIME = "${config.system.locale}";
    };

    fonts.enableDefaultPackages = true;
    fonts.packages = with pkgs; [
      nerd-fonts.fira-code
    ];

    services.xserver.xkb = "${config.system.xkb.layout}";
    services.openssh.enable = true;
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;
    };

    security.pam.loginLimits = [
      {
        domain = "@users";
        item = "rtprio";
        type = "-";
        value = 1;
      }
    ];

    users.users.${config.system.user} = {
      isNormalUser = true;
      description = "A user account.";
      extraGroups = [ "networkmanager" "wheel" "video" ];
    };

    ### Home Manager ###

    home-manager = {
      extraSpecialArgs = { inherit inputs; };
      useGlobalPkgs = true;
      useUserPackages = true;
      users.${config.system.user} = {
        imports = [
          ./home/default.nix
        ];
      };
    };

    system.stateVersion = "24.11";
  };
}
