{
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    nixos-generators = {
      url = "github:nix-community/nixos-generators";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs =
    { nixos-generators, nixpkgs, ... }:
    {
      packages.x86_64-linux.default = nixos-generators.nixosGenerate {
        system = "x86_64-linux";
        format = "virtualbox";
        modules = [
          ./configuration.nix
          {
            nix.registry.nixpkgs.flake = nixpkgs;
            virtualisation.diskSize = 20 * 1024;
          }
        ];
      };
    };
}
