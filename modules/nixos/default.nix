{ pkgs, lib, ... }: {
	imports = [
		./guest-vm.nix
		./gnome.nix
		./nvidia.nix
	];

	# settings to enable across all devices
	nix.settings.experimental-features = [ "nix-command" "flakes" ];
	environment.systemPackages = with pkgs; [
		neovim
		git
		zsh
		nerdfonts
		lsd
		syncthing #it is possible to start the service via nixconfig, although it would only support a single user
	];
	
	services.tailscale.enable = true;
}
