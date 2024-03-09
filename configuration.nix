{ config, lib, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./apple-silicon-support
  ];

  nixpkgs.config.allowUnfree = true;

  users.users.katie = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    packages = with pkgs; [
    ];
  };

  environment = {
    variables = {
      EDITOR = "nvim";
      VISUAL = "nvim";
    };

    systemPackages = with pkgs; [
      neovim
      firefox
      tree
      nushell
      git
      vscodium
      webcord
    ];
  };

  programs = {
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
        sddm.enable = true;
        autoLogin = {
          enable = true;
          user = "katie";
        };
      };

      desktopManager.plasma5.enable = true;
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
    ];
  };

  boot.loader.systemd-boot.enable = true; 
  boot.loader.efi.canTouchEfiVariables = false;

  time.timeZone = "America/Chicago";
  sound.enable = true;
  hardware.bluetooth.enable = true;
  networking.hostName = "Anathema";
  networking.wireless.iwd = {
    enable = true;
    settings.General.EnableNetworkConfiguration = true;
  };

  # DO NOT EDIT BELOW
  system.stateVersion = "24.05";
}

