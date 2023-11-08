{ username, config, pkgs, stdenv, lib, ... }:

# Tolga Erok
# 10/6/2023
# My personal NIXOS KDE configuration 
# 
# ¯\_(ツ)_/¯
#---------------------------------------------------------------------
# BLUE-TOOTH     REALTEK 5G
# CPU	           Intel(R) Core(TM) i7-4770 CPU @ 3.40GHz x 8 (Haswell)
# GPU	           NVIDIA GeForce GT 1030/PCIe/SSE2
# MODEL          HP EliteDesk 800 G1 SFF
# MOTHERBOARD	   Intel® Q87
# NETWORK	       Intel Corporation Wi-Fi 6 AX210/AX211/AX411 160MHz
# RAM	           28 GB DDR3
# SATA           SAMSUNG SSD 870 EVO 500GB
#---------------------------------------------------------------------

{

  imports = [

    # Select your kernel
    #---------------------------------------------
    # ../../core/system-tweaks/kernel-upgrades/xanmod.nix                     # Xanmod kernel
    # ../../core/system-tweaks/kernel-upgrades/zen.nix                        # Zen kernel
    ../../../core/system-tweaks/kernel-upgrades/latest-standard.nix           # Latest default NixOS kernel

    # Main core
    # ---------------------------------------------
    ../../../core
    ../../../core/boot/grub/grub.nix                                          # Use GRUB loader on this machine, not EFI
    ../../../core/gpu/nvidia/nvidia-stable-opengl                             # NVIDIA with hardware acceleration (Open-GL) for GT-1030++
    ./EliteDesk-800-G1-hardware-configuration.nix

    # Custom System tweaks
    # ---------------------------------------------
    # ../../../core/system-tweaks/zram/zram-28GB-SYSTEM.nix                   # Zram tweak for 28GB
    ../../../core/system-tweaks/kernel-tweaks/28GB-SYSTEM/28GB-SYSTEM.nix     # Kernel tweak for 28GB
    ../../../core/system-tweaks/storage-tweaks/SSD/SSD-tweak.nix              # SSD read & write tweaks

    # Users && user settings
    # ---------------------------------------------
    ../../../user/SOS/SOS.nix
    ../../../user/tolga/tolga.nix
    ../../../user/user-home-settings

  ];

  # Name of your pc to appear on the Network
  #---------------------------------------------------------------------
  networking.hostName = "HP-G800";                                            # Define your hostname.

}
