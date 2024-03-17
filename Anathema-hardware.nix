{
  config,
  lib,
  pkgs,
  modulesPath,
  ...
}: {
  # DO NOT EDIT
  imports = [
    ./asahi.nix
    (modulesPath + "/installer/scan/not-detected.nix")
  ];
  boot.initrd.availableKernelModules = ["sdhci_pci"];
  boot.initrd.kernelModules = [];
  boot.kernelModules = [];
  boot.extraModulePackages = [];
  fileSystems."/" = {
    device = "/dev/disk/by-uuid/6258c3e6-3b95-49a2-8b91-c8511a727b22";
    fsType = "ext4";
  };
  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/F6B1-1410";
    fsType = "vfat";
  };
  swapDevices = [];
  networking.useDHCP = lib.mkDefault true;
  nixpkgs.hostPlatform = lib.mkDefault "aarch64-linux";
}
