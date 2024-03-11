{...}: {
  imports = [./apple-silicon-support];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = false;

  hardware.asahi.useExperimentalGPUDriver = true;
  programs.light.enable = true;
  services.actkbd = {
    enable = true;
    bindings = [
      {
        keys = [225];
        events = ["key"];
        command = "/run/current-system/sw/bin/light -A 10";
      }
      {
        keys = [224];
        events = ["key"];
        command = "/run/current-system/sw/bin/light -U 10";
      }
      {
        keys = [113];
        events = ["key"];
        command = "/run/current-system/sw/bin/amixer set Master toggle";
      }
      {
        keys = [114];
        events = ["key"];
        command = "/run/current-system/sw/bin/runuser -l katie -c 'amixer -q set Master 5%- unmute'";
      }
      {
        keys = [115];
        events = ["key"];
        command = "/run/current-system/sw/bin/runuser -l katie -c 'amixer -q set Master 5%+ unmute'";
      }
    ];
  };
}
