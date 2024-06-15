{ pkgs, lib, config, ...}: {
	options = {
		# change this to module name
		terminal.enable =
			lib.mkEnableOption "Enables various terminal/shell related programs and goodies";
	};

	# and change this to the module name
	config = lib.mkIf config.terminal.enable {
		programs.zsh.enable = true;
		environment.systemPackages = with pkgs; [
			alacritty
			lsd
			bat
			ansible
			nerdfonts
		];
	};
}
