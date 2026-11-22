{
  description = "Yohaku Linux - NixOS configuration";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

  outputs = { self, nixpkgs, ... }:
    let
      system = "x86_64-linux";
    in
    {
      nixosConfigurations.yohaku-live = nixpkgs.lib.nixosSystem {
        inherit system;

        modules = [
          ./nixos/modules/core.nix
          ./nixos/modules/japanese.nix
          ./nixos/modules/desktop.nix
          ./nixos/modules/packages.nix
          ./nixos/iso/live.nix
        ];
      };

      packages.${system}.iso =
        self.nixosConfigurations.yohaku-live.config.system.build.isoImage;
    };
}
