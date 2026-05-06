{
  description = "Minimal NixOS flake";

	inputs = {
		nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
		home-manager = {
			url = "github:nix-community/home-manager";
			inputs.nixpkgs.follows = "nixpkgs";
		};
	};

  outputs = { self, nixpkgs, ...}@inputs:
  let
    system = "x86_64-linux";
  in {
    nixosConfigurations.puppybox = nixpkgs.lib.nixosSystem {
      specialArgs = {inherit inputs;};
      modules = [
        ./configuration.nix
	inputs.home-manager.nixosModules.default
      ];
    };
  };
}

