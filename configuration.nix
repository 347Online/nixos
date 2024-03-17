{
  config,
  lib,
  pkgs,
  ...
}: {
  nixpkgs.config.allowUnfree = true;

  users.users.katie = {
    shell = pkgs.nushell;
    isNormalUser = true;
    extraGroups = ["wheel"];
    packages = with pkgs; [
    ];
  };

  users.users.twelve = {
    shell = pkgs.bash;
    isNormalUser = true;
    extraGroups = ["wheel"];
    packages = with pkgs; [
    ];
  };

  fonts = {
    enableDefaultPackages = true;
    packages = with pkgs; [
      font-awesome
      jetbrains-mono
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-cjk-serif
      noto-fonts-lgc-plus
      (nerdfonts.override {fonts = ["JetBrainsMono" "NerdFontsSymbolsOnly"];})
    ];
  };

  nix.settings.experimental-features = ["nix-command" "flakes"];

  environment = {
    systemPackages = with pkgs; [
      home-manager
      neofetch
      firefox
      nushell
      git
      webcord
      kitty
      waybar
      mako
      libnotify
      rofi
      bluetuith
      libsForQt5.kdeconnect-kde
      killall
    ];
  };

  programs = {
    neovim = {
      enable = true;
      defaultEditor = true;
    };
    hyprland = {
      enable = true;
      xwayland.enable = true;
    };
    _1password.enable = true;
    _1password-gui = {
      enable = true;
      polkitPolicyOwners = ["katie"];
    };
  };

  services = {
    openssh.enable = true;
    printing.enable = true;
    pipewire = {
      enable = true;
      alsa = {
        enable = true;
        support32Bit = true;
      };
      pulse.enable = true;
    };
    xserver = {
      enable = true;
      xkb.layout = "us";
      displayManager = {
        autoLogin = {
          enable = true;
          user = "katie";
        };
      };
    };
  };

  sound.enable = true;
  time.timeZone = "America/Chicago";
  hardware.bluetooth = {
    enable = true;
    settings = {
      General = {
        Name = "Hello";
        ControllerMode = "dual";
        FastConnectable = "true";
        Experimental = "true";
      };
      Policy = {
        AutoEnable = "true";
      };
    };
  };

  networking.wireless.iwd = {
    enable = true;
    settings.General.EnableNetworkConfiguration = true;
  };

  # DO NOT EDIT BELOW
  system.stateVersion = "24.05";
}
