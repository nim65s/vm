{
  inputs = {
    flake-parts.url = "github:hercules-ci/flake-parts";
    nixpkgs.url = "nixpkgs/nixos-unstable";
    nixos-generators = {
      url = "github:nix-community/nixos-generators";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs =
    inputs:
    let
      system = "x86_64-linux";
    in
    inputs.flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [ system ];
      flake.nixosConfigurations.nixos = inputs.nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          ./configuration.nix
          {
            nix.registry.nixpkgs.flake = inputs.nixpkgs;
            boot.loader.grub.device = "/dev/sda";
            fileSystems."/".device = "/dev/sda1";
          }
        ];
      };
      perSystem =
        { pkgs, ... }:
        {
          packages.default = inputs.nixos-generators.nixosGenerate {
            inherit system;
            format = "virtualbox";
            modules = [
              ./configuration.nix
              {
                nix.registry.nixpkgs.flake = inputs.nixpkgs;
                virtualisation.diskSize = 20 * 1024;
              }
            ];
          };
        };
    };
}
