# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{ config, lib, pkgs, modulesPath, ... }:

{
  imports = [ (modulesPath + "/installer/scan/not-detected.nix") ];

  boot.initrd.availableKernelModules = [
    "xhci_pci"
    "ehci_pci"
    "ahci"
    "usb_storage"
    "sd_mod"
    "sdhci_pci"
    "aesni_intel"
  ];
  boot.initrd.kernelModules = [  ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];
  boot.kernelParams = [ "mitigations=off" ];

  fileSystems."/" =
    { device = "/dev/disk/by-uuid/50d21cc2-7897-4b42-8dc5-088c9a64769f";
      fsType = "ext4";
    # for ssd
    options =
      [ "noatime" "nodiratime" "discard" "errors=remount-ro" "data=ordered" ];

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/C473-D73B";
      fsType = "vfat";
    };

  swapDevices =
    [ { device = "/dev/disk/by-uuid/6e2ee867-7220-4cc9-96b0-8321a7417182"; }
    ];

#  fileSystems."/mnt/nixos_share" = {
#    device = "//192.168.0.20/LinuxData/HOME/PROFILES/NIXOS-23-05/TOLGA/";
#    fsType = "cifs";
#    options = let
#      automountOpts =
#        "x-systemd.automount,noauto,x-systemd.idle-timeout=60,x-systemd.device-timeout=5s,x-systemd.mount-timeout=5s,x-systemd.requires=network.target";
#      uid =
#        "1000"; # Replace with your actual user ID, use `id -u <YOUR USERNAME>` to get your user ID
#      gid =
#        "100"; # Replace with your actual group ID, use `id -g <YOUR USERNAME>` to get your group ID
#      vers = "3.1.1";
#      cacheOpts = "cache=loose";
#      credentialsPath = "/etc/nixos/hardware-configuration/network/smb-secrets";
#    in [
#      "${automountOpts},credentials=${credentialsPath},uid=${uid},gid=${gid},vers=${vers},${cacheOpts}"
#    ];
#  };

  #---------------------------------------------------------------------
  # For AMD hardware / chipsets
  #---------------------------------------------------------------------

  # hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

  #---------------------------------------------------------------------
  # For Intel hardware / chipsets
  #---------------------------------------------------------------------

  hardware.cpu.intel.updateMicrocode =
    lib.mkDefault config.hardware.enableRedistributableFirmware;

  #---------------------------------------------------------------------
  # Tell Nix to use appropriate packages and configurations for this 
  # platform if they are not explicitly defined otherwise.
  #---------------------------------------------------------------------

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  networking.useDHCP = lib.mkDefault true;
}
