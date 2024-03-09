{ config, lib, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./apple-silicon-support
  ];

  boot.loader.systemd-boot.enable = true; 
  boot.loader.efi.canTouchEfiVariables = false;

  nixpkgs.config.allowUnfree = true;

  time.timeZone = "America/Chicago";

  networking.hostName = "Anathema";
  networking.wireless.iwd = {
    enable = true;
    settings.General.EnableNetworkConfiguration = true;
  };

  services.xserver = {
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

  services.printing.enable = true;

  sound.enable = true;
  hardware.pulseaudio.enable = true;
  hardware.bluetooth.enable = true;

  users.users.katie = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    packages = with pkgs; [
    ];
  };

  programs._1password.enable = true;
  programs._1password-gui = {
    enable = true;
    polkitPolicyOwners = [ "katie" ];
  };

  environment.systemPackages = with pkgs; [
    neovim
    firefox
    tree
    nushell
    git
    vscodium
  ];

  environment.variables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
  };

  services.openssh.enable = true;

  # DO NOT EDIT BELOW
  system.stateVersion = "24.05";
}

