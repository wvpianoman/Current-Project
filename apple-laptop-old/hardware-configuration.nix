{ config, lib, pkgs, modulesPath, ... }:

#--------------------------------------------------------------------- 
# Default Hardware Configuration for current pc
#--------------------------------------------------------------------- 

{
  imports = [ (modulesPath + "/installer/scan/not-detected.nix") ];

  boot.initrd.availableKernelModules = [
    "applespi" # MacBook (Pro) SPI keyboard and touchpad driver
    "intel_lpss_pci" # Intel Low Power Subsystem support in PCI mode
    "mac_hid" # HID support stuff for Macintosh computers.
    "spi_pxa2xx_platform" # SPI keyboard / trackpad found on 12" MacBooks (2015 and later) and newer MacBook Pros (late 2016 and later).
    "spi_pxa2xx_pci" # PCI glue driver for SPI PXA2xx compatible controllers.
    "usbcore"

    "xhci_pci"
    "ehci_pci"
    "ahci"
    "firewire_ohci"
    "usb_storage"
    "usbhid"
    "sd_mod"
    "sr_mod"
    "sdhci_pci"
  ];
  systemd.services.fix-suspend = {
    script = ''
      
            # Fix macbook 12 suspend issues
            echo 0 > /sys/bus/pci/devices/0000:01:00.0/d3cold_allowed
    '';
    wantedBy = [ "multi-user.target" ];
  };

  # boot.extraModulePackages = [ ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-intel" "wl" ];
  boot.extraModulePackages = [ config.boot.kernelPackages.broadcom_sta ];
  boot.kernelParams = [ "mitigations=off" ];

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/a19fe475-fea4-4053-afa7-1608e18598a5";
    fsType = "ext4";
    # for ssd
    options =
      [ "noatime" "nodiratime" "discard" "errors=remount-ro" "data=ordered" ];
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/2B95-47BA";
    fsType = "vfat";
  };

  swapDevices =
    [{ device = "/dev/disk/by-uuid/b76b10a3-95ef-446b-9a6b-2e8836375403"; }];

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
  #      credentialsPath = "/etc/nixos/system/network/smb-secrets";
  #    in [
  #      "${automountOpts},credentials=${credentialsPath},uid=${uid},gid=${gid},vers=${vers},${cacheOpts}"
  #    ];
  #  };

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
