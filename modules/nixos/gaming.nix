{ pkgs, lib, config, ...}: {
	options = {
		# change this to module name
		gaming.enable =
			lib.mkEnableOption "Enables GNOME desktop and related software";
	};

	# and change this to the module name
	config = lib.mkIf config.gaming.enable {
		programs.steam.enable = true;
		programs.steam.gamescopeSession.enable = true;
		environment.systemPackages = with pkgs; [
			mangohud
			protonup
			protonup-qt
			heroic
			bottles
			prismlauncher #mc launcher
			cartridges
		];
		programs.gamemode.enable = true;
	};
}
