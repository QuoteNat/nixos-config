{ pkgs, lib, config, ...}: {
	options = {
		# change this to module name
		flatpak.enable =
			lib.mkEnableOption "Enables GNOME desktop and related software";
	};

	# and change this to the module name
	config = lib.mkIf config.flatpak.enable {
		services.flatpak.enable = true;
	};
}
