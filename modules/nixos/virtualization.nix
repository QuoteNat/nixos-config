{ pkgs, lib, config, ...}: {
	options = {
		# change this to module name
		virtualization.enable =
			lib.mkEnableOption "Enables GNOME desktop and related software";
	};

	# and change this to the module name
	config = lib.mkIf config.virtualization.enable {
		virtualisation.libvirtd.enable = true;
		programs.virt-manager.enable = true;
	};
}
