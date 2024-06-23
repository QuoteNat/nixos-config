{ pkgs, lib, config, ...}: 
{
	options = {
		gnome.enable =
			lib.mkEnableOption "Enables GNOME desktop and related software";
	};

	config = lib.mkIf config.gnome.enable {
		services.xserver.enable = true;
		services.xserver.desktopManager.gnome = {
    		enable = true;
      		extraGSettingsOverridePackages = [pkgs.gnome.mutter];
	        extraGSettingsOverrides = ''
        		[org.gnome.mutter]
        		experimental-features=['variable-refresh-rate', 'scale-monitor-framebuffer']
      		'';
    		};
		services.xserver.displayManager.gdm.enable = true;		
		environment.systemPackages = (with pkgs; [
			gnome-extension-manager
			gnome.gnome-tweaks
			pika-backup
			adw-gtk3
      resources
      metadata-cleaner
      gnome-obfuscate
		]) 
    ++
    (with pkgs.gnomeExtensions; [
			hot-edge
			appindicator	
			caffeine
      just-perfection
      alphabetical-app-grid
    ]);
  };
}
