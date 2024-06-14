{ pkgs, lib, config, ...}: {
	options = {
		# change this to module name
		chat.enable =
			lib.mkEnableOption "Enables chat software";
	};

	# and change this to the module name
	config = lib.mkIf config.chat.enable {
		environment.systemPackages = with pkgs; [
			vesktop
		];
	};
}
