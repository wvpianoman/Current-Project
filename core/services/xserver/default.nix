{ config, lib, ... }:

{

  #---------------------------------------------------------------------
  # Enable the X11 windowing system && KDE Plasma Desktop Environment.
  #---------------------------------------------------------------------

  imports = [

    # Choose DE, still under review

    # ./budgie/budgie.nix
    # ./cinnamon/cinnamon.nix
    # ./enlightenment/enlightenment.nix
    # ./gnome/gnome.nix
    # ./hyperland/hyperland.nix
    # ./i3/i3.nix
    # ./kde/kde.nix
    # ./sway/sway.nix
    # ./xfce/xfce.nix

  ];

  services.xserver = {
    enable = true;

    # scaling of fonts and graphical elements on the screen
    dpi = 98;

    libinput.enable =
      true; # Enable touchpad support (enabled default in most desktopManager).

    desktopManager = {

      plasma5.enable = true;
    };

    displayManager = {
      sddm = {
        enable = true;
        autoNumlock = true;

      };
    };

    # ---------------------------------------------------------------------
    # Vidoe settings that go hand-in-hand with opengl
    # ---------------------------------------------------------------------
    videoDrivers = [

      "fbdev" # The fbdev (Framebuffer Device) driver is a generic framebuffer driver that provides access to the frame buffer of the display hardware.
      # "modesetting"     # The modesetting driver is a generic driver for modern video hardware that relies on kernel modesetting (KMS) to set the display modes and manage resolution and refresh rate.
      # "amdgpu"          # This is the open-source kernel driver for AMD graphics cards. It's part of the AMDGPU driver stack and provides support for newer AMD GPUs.
      # "nouveau"         # Nouveau is an open-source driver for NVIDIA graphics cards. It aims to provide support for NVIDIA GPUs and is an alternative to the proprietary NVIDIA driver
      # "radeon"          # The Radeon driver is an open-source driver for AMD Radeon graphics cards. It provides support for older AMD GPUs.

    ];

  };

  # Old notes to self
  #---------------------------------------------------------------------
  # Enable the KDE Plasma Desktop Environment.
  #---------------------------------------------------------------------
  # services.xserver.displayManager.sddm.enable = true;
  # services.xserver.desktopManager.plasma5.enable = true;

}
