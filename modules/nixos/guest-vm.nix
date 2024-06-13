{ nixpkgs, lib, config, ...}:
{
	options = {
		guest-vm.enable =
			lib.mkEnableOption "Enables nixos guest vm services";
	};

	config = lib.mkIf config.guest-vm.enable {
		services.spice-vdagentd.enable = true;
	};
}
					 
	
	
