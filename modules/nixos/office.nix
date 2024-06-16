
{ pkgs, lib, config, ...}: {
	options = {
		# change this to module name
		office.enable =
			lib.mkEnableOption "Enables office and work software";
	};

	# and change this to the module name
	config = lib.mkIf config.office.enable {
		environment.systemPackages = with pkgs; [
			libreoffice
			thunderbird
			kmymoney
			joplin-desktop
		];
	};
}
