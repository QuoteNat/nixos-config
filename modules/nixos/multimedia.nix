{ pkgs, lib, config, ...}: {
	options = {
		# change this to module name
		multimedia.enable =
			lib.mkEnableOption "Enables multimedia software";
	};

	# and change this to the module name
	config = lib.mkIf config.multimedia.enable {
		environment.systemPackages = with pkgs; [
			tauon
			soundconverter
			mpv
			gthumb
		];
	};
}
