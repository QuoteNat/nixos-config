{ pkgs, lib, config, ...}: {
	options = {
		gnome.enable =
			lib.mkEnableOption "Enables GNOME desktop and related software";
	};

	config = lib.mkIf config.gnome.enable {
		services.xserver.enable = true;
		services.xserver.desktopManager.gnome.enable = true;
		services.xserver.displayManager.gdm.enable = true;		
		environment.systemPackages = with pkgs; [
			gnome-extension-manager
			gnome.gnome-tweaks
			pika-backup
			gnomeExtensions.hot-edge
			gnomeExtensions.appindicator	
			gnomeExtensions.caffeine
		];
	};
}
