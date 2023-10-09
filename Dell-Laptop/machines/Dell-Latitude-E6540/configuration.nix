# MODEL:      	Dell Latitude E6540 
# BIOS:       	Dell BIOS A17 12/01/2015
# MOTHERBOARD:	Dell Motherboard 0CYT5F A00
# CPU:        	Intel Core i7-4800MQ CPU @ 2.70GHz
# GPU:        	Intel 4th Gen Core Processor Integrated Graphics Controller
# GPU:          AMD/ATI Mars XTX [Radeon HD 8790M]
# RAM:        	2x RAM Module 8GB SODIMM DDR3 1600MT/s
# HARD DRIVE: 	PNY CS900 1TB SSD
# NETWORK:    	Intel  	Centrino Ultimate-N 6300
# BLUETOOTH:  	
#--------------------------------------------------------------------------------------------------------------------------

{ config, pkgs, ... }:

{
  imports = [

    ./core/common
    ./core/system-tweaks/kernel-tweaks/16GB-SYSTEM/16GB-SYSTEM.nix
    ./core/system-tweaks/storage-tweaks/SSD/SSD-tweak.nix
    ./gpu/intel/HD-INTEL.nix
    ./hardware-configuration.nix
    ./user
    
  ];

  # -----------------------------------------------------------------
  #   Bootloader.
  # -----------------------------------------------------------------
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "Dell-HP-ProBook"; # Define your hostname.

  #---------------------------------------------------------------------
  #   Allow unfree packages
  #--------------------------------------------------------------------- 
  nixpkgs.config.allowUnfree = true;

  #---------------------------------------------------------------------
  #   Enable the OpenSSH daemon.
  #---------------------------------------------------------------------
  services.openssh.enable = true;

  # -----------------------------------------------------------------
  #   Enable networking
  # -----------------------------------------------------------------
  networking.networkmanager.enable = true;

  #---------------------------------------------------------------------
  # Switch to most recent kernel available
  #---------------------------------------------------------------------
#  boot.kernelPackages = pkgs.linuxPackages_latest;
#  boot.kernelPackages = pkgs.linuxPackages_xanmod; #(6.3)
#  boot.kernelPackages = pkgs.linuxPackages_xanmod_latest; #(6.4)
#  boot.kernelPackages = pkgs.linuxPackages_xanmod_stable; #(6.4 hardened)
#  boot.kernelPackages = pkgs.linuxPackages_xanmod_tt; #(6.5)

  # -----------------------------------------------------------------
  #   Enable the X11 windowing system.
  # -----------------------------------------------------------------
  services.xserver.enable = true;

  # -----------------------------------------------------------------
  #   Enable the KDE Plasma Desktop Environment.
  # -----------------------------------------------------------------
  services.xserver.displayManager.sddm.enable = true;
  services.xserver.desktopManager.plasma5.enable = true;

  #---------------------------------------------------------------------
  # Enable automatic login for the user.
  #---------------------------------------------------------------------
  services.xserver.displayManager.autoLogin.enable = true;
  services.xserver.displayManager.autoLogin.user = "brian";

  # -----------------------------------------------------------------
  #   Enable CUPS to print documents.
  # -----------------------------------------------------------------
  services.printing.enable = true;

  # -----------------------------------------------------------------
  #   Enable sound with pipewire.
  # -----------------------------------------------------------------
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;

  };

  # -----------------------------------------------------------------
  #   Enable touchpad support (enabled default in most desktopManager).
  # -----------------------------------------------------------------
  services.xserver.libinput.enable = true;

  environment.systemPackages = with pkgs;
    [
      #  vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
      #  wget
    ];

  #---------------------------------------------------------------------
  #   Automatic system upgrades, automatically reboot after an upgrade if
  #   necessary
  #---------------------------------------------------------------------
  # system.autoUpgrade.allowReboot = true;  # Very annoying .
  system.autoUpgrade.enable = true;
  system.copySystemConfiguration = true;
  system.stateVersion = "23.05";
  systemd.extraConfig = "DefaultTimeoutStopSec=10s";

}
