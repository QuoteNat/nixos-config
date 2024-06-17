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
		./flatpak.nix
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

  # Limit the number of generations to keep
  boot.loader.systemd-boot.configurationLimit = 10;
  # boot.loader.grub.configurationLimit = 10;

  # Perform garbage collection weekly to maintain low disk usage
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 1w";
  };

  # Optimize storage
  # You can also manually optimize the store via:
  #    nix-store --optimise
  # Refer to the following link for more details:
  # https://nixos.org/manual/nix/stable/command-ref/conf-file.html#conf-auto-optimise-store
  nix.settings.auto-optimise-store = true;
}
