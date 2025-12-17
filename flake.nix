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
      modules = [
        ./configuration.nix
        {
          nix.registry.nixpkgs.flake = inputs.nixpkgs;
          virtualisation.diskSize = 20 * 1024;
        }
      ];
    in
    inputs.flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [ system ];
      flake.nixosConfigurations.vm = inputs.nixpkgs.lib.nixosSystem {
        inherit modules system;
      };
      perSystem =
        { pkgs, ... }:
        {
          devShells.default = pkgs.mkShell {
            packages = with pkgs; [
              curl
              gedit
              git
              nano
              uv
              vim
            ];
          };
          packages.default = inputs.nixos-generators.nixosGenerate {
            inherit modules system;
            format = "virtualbox";
          };
        };
    };
}
