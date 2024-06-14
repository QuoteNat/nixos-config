{ pkgs, lib, config, ...}: {
	options = {
		nvidia.enable =
			lib.mkEnableOption "Enable proprietary nvidia drivers";
	};

	# and change this to the module name
	config = lib.mkIf config.nvidia.enable {
		  # Enable OpenGL
		  hardware.opengl = {
		    enable = true;
		    driSupport = true;
		    driSupport32Bit = true;
		  };

		  # Load nvidia driver for Xorg and Wayland
		  services.xserver.videoDrivers = ["nvidia"];

		  hardware.nvidia = {

		    # Modesetting is required.
		    modesetting.enable = true;

		    # Nvidia power management. Experimental, and can cause sleep/suspend to fail.
		    # Enable this if you have graphical corruption issues or application crashes after waking
		    # up from sleep. This fixes it by saving the entire VRAM memory to /tmp/ instead 
		    # of just the bare essentials.
		    powerManagement.enable = true;

		    # Fine-grained power management. Turns off GPU when not in use.
		    # Experimental and only works on modern Nvidia GPUs (Turing or newer).
		    powerManagement.finegrained = false;

		    # Use the NVidia open source kernel module (not to be confused with the
		    # independent third-party "nouveau" open source driver).
		    # Support is limited to the Turing and later architectures. Full list of 
		    # supported GPUs is at: 
		    # https://github.com/NVIDIA/open-gpu-kernel-modules#compatible-gpus 
		    # Only available from driver 515.43.04+
		    # Currently alpha-quality/buggy, so false is currently the recommended setting.
		    open = false;

		    # Enable the Nvidia settings menu,
			# accessible via `nvidia-settings`.
		    nvidiaSettings = true;

		    # Optionally, you may need to select the appropriate driver version for your specific GPU.
		    package = config.boot.kernelPackages.nvidiaPackages.mkDriver {
		    	version = "555.52.04";
			sha256_64bit = "sha256-nVOubb7zKulXhux9AruUTVBQwccFFuYGWrU1ZiakRAI=";
			sha256_aarch64 = lib.fakeSha256;
			openSha256 = "sha256-PMh5efbSEq7iqEMBr2+VGQYkBG73TGUh6FuDHZhmwHk=";
			settingsSha256 = "sha256-PMh5efbSEq7iqEMBr2+VGQYkBG73TGUh6FuDHZhmwHk=";
			persistencedSha256 = lib.fakeSha256;
		  };	
		};
		# Fix instability issues with firefox under wayland causing it to crash
		environment.sessionVariables = rec {
			MOZ_ENABLE_WAYLAND = "0";
		};	
	};
}
