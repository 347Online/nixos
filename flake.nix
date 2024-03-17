{
  description = "Katie's NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs = {
    self,
    nixpkgs,
  } @ inputs: let
    system = "aarch64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
  in {
    nixosConfigurations.Anathema = nixpkgs.lib.nixosSystem {
      specialArgs = {inherit inputs;};
      modules = [
        {
          networking.hostName = "Anathema";
          environment.variables.GDK_SCALE = "2";
        }
        ./Anathema-hardware.nix
        ./configuration.nix
      ];
    };
  };
}
