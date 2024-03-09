{ config, lib, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./apple-silicon-support
  ];

  nixpkgs.config.allowUnfree = true;

  users.users.katie = {
    shell = pkgs.nushell;
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    packages = with pkgs; [
    ];
  };

  fonts.enableDefaultPackages = true;

  environment = {
    variables = {
      # NIXOS_OZONE_WL = "1";
      GDK_SCALE = "2";
    };

    systemPackages = with pkgs; [
      neofetch
      firefox
      nushell
      git
      vscodium
      webcord
      kitty
      home-manager
      eza
      waybar
      mako
      libnotify
      rofi
    ];
  };

  programs = {
    neovim = {
      enable = true;
      defaultEditor = true;
    };
    fish.enable = true;
    hyprland = {
      enable = true;
      xwayland.enable = true;
    };
    _1password.enable = true;
    _1password-gui = {
      enable = true;
      polkitPolicyOwners = [ "katie" ];
    };
  };

  services = {
    openssh.enable = true;
    printing.enable = true;
    xserver = {
      enable = true;
      xkb.layout = "us";
      displayManager = {
        sddm = {
	  enable = true;
	  wayland.enable = true;
	};
        autoLogin = {
          enable = true;
          user = "katie";
        };
      };

      # desktopManager.plasma5.enable = true;
      libinput = {
        enable = true;
        touchpad = {
          tapping = true;
          middleEmulation = true;

          additionalOptions = ''
            Option "PalmDetection" "on"
            Option "TappingButtonMap" "lrm"
          '';
        };
      };
    };
  };

  # Asahi-specific
  hardware.asahi.useExperimentalGPUDriver = true;
  programs.light.enable = true;
  services.actkbd = {
    enable = true;
    bindings = [
      { keys = [ 225 ]; events = [ "key" ]; command = "/run/current-system/sw/bin/light -A 10"; }
      { keys = [ 224 ]; events = [ "key" ]; command = "/run/current-system/sw/bin/light -U 10"; }
      { keys = [ 113 ]; events = [ "key" ]; command = "/run/current-system/sw/bin/amixer set Master toggle"; }
      { keys = [ 114 ]; events = [ "key" ]; command = "/run/current-system/sw/bin/runuser -l katie -c 'amixer -q set Master 5%- unmute'"; }
      { keys = [ 115 ]; events = [ "key" ]; command = "/run/current-system/sw/bin/runuser -l katie -c 'amixer -q set Master 5%+ unmute'"; }
    ];
  };

  boot.loader.systemd-boot.enable = true; 
  boot.loader.efi.canTouchEfiVariables = false;

  sound.enable = true;
  time.timeZone = "America/Chicago";
  hardware.bluetooth.enable = true;
  networking.hostName = "Anathema";
  networking.wireless.iwd = {
    enable = true;
    settings.General.EnableNetworkConfiguration = true;
  };

  # DO NOT EDIT BELOW
  system.stateVersion = "24.05";
}

