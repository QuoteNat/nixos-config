# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{ config, lib, pkgs, modulesPath, ... }:

{
  imports =
    [ (modulesPath + "/installer/scan/not-detected.nix")
    ];

  boot.initrd.availableKernelModules = [ "xhci_pci" "ahci" "nvme" "usbhid" "sd_mod" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" =
    { device = "/dev/disk/by-uuid/36e76b3d-861a-4a38-b0c0-3d3de758eef6";
      fsType = "ext4";
    };

  boot.initrd.luks.devices."luks-c99f0611-ab4e-47ba-9f36-779e331da3bc".device = "/dev/disk/by-uuid/c99f0611-ab4e-47ba-9f36-779e331da3bc";

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/119E-8638";
      fsType = "vfat";
      options = [ "fmask=0022" "dmask=0022" ];
    };

  fileSystems."/mnt/data" =
    { device = "/dev/disk/by-uuid/c8768706-e78d-46d0-a757-093ec29978ac";
      fsType = "ext4";
    };

  boot.initrd.luks.devices."Data".device = "/dev/disk/by-uuid/985b2040-d5aa-414e-b42b-133b465ecb22";

  swapDevices =
    [ { device = "/dev/disk/by-uuid/2ff74547-ed18-4970-852e-f7298379f71d"; }
    ];

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.enp4s0.useDHCP = lib.mkDefault true;
  # networking.interfaces.tailscale0.useDHCP = lib.mkDefault true;
  # networking.interfaces.wlo1.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
