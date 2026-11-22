{
  description = "Yohaku Linux - a NixOS-based desktop distribution";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    # NXC remains an independently maintained project. Reuse this Flake
    # input so Yohaku can ship its CLI and NXC LOUNGE packages.
    nxc = {
      url = "github:nxc-project/nixos-json-controller";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, nxc, ... }:
    let
      system = "x86_64-linux";
    in
    {
      nixosConfigurations.yohaku-live = nixpkgs.lib.nixosSystem {
        inherit system;

        specialArgs = {
          inherit nxc;
        };

        modules = [
          ./nixos/modules/base.nix
          ./nixos/modules/japanese.nix
          ./nixos/modules/hardware.nix
          ./nixos/modules/desktop/niri.nix
          ./nixos/modules/desktop/packages.nix
          ./nixos/iso/live.nix
        ];
      };

      packages.${system}.iso =
        self.nixosConfigurations.yohaku-live.config.system.build.isoImage;
    };
}
