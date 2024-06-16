{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";
		nixpkgs-unstable.url = "nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs, nixpkgs-unstable, ... }@inputs: 
	let
		system = "x86_64-linux";
		overlay-unstable = final: prev: {
			 unstable = import nixpkgs-unstable {
			   inherit system;
			   config.allowUnfree = true;
			 };
		};
	in
	{
    nixosConfigurations = {
		test-vm = nixpkgs.lib.nixosSystem {
						specialArgs = {inherit inputs;};
						modules = [
							./hosts/test-vm/configuration.nix
							# inputs.home-manager.nixosModules.default
						];
					};
		home = nixpkgs.lib.nixosSystem {
						specialArgs = {inherit inputs;};
						modules = [
							({ config, pkgs, ... }: { nixpkgs.overlays = [ overlay-unstable ]; })
							./hosts/home/configuration.nix
						];
		};
		};
  };
}
