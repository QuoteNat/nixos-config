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
    nvd # shows changes between nix generations
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

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.nat = {
    isNormalUser = true;
    description = "Nat";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
    #  thunderbird
    ];
  };

  environment.variables.EDITOR = "nvim";

  # Install firefox.
  programs.firefox.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
}
