{ pkgs, lib, ... }: {
	imports = [
		./guest-vm.nix
		./gnome.nix
		./nvidia.nix
		./gaming.nix
		./multimedia.nix
		./chat.nix
		./virtualization.nix
		./terminal.nix
		./office.nix
	];

	# settings to enable across all devices
	nix.settings.experimental-features = [ "nix-command" "flakes" ];
	environment.systemPackages = with pkgs; [
		neovim
		git
		syncthing #it is possible to start the service via nixconfig, although it would only support a single user
		keepassxc
	];
	
	services.tailscale.enable = true;
}
