{ pkgs, lib, config, ...}: {
	options = {
		# change this to module name
		template.enable =
			lib.mkEnableOption "Enables GNOME desktop and related software";
	};

	# and change this to the module name
	config = lib.mkIf config.template.enable {
		# Insert all module settings here
	};
}
