{ config, lib, ... }:

{

  imports = [ 
    
    # Import miniDLNA
    # ---------------------------------------------
    # ./plex.nix
    ./miniDLNA.nix
    
  ];

  #--------------------------------------------------------------------- 
  # Enable networking
  #---------------------------------------------------------------------
  networking = {
    networkmanager = {
      enable = true;
      # Append Cloudflare and Google DNS servers
      appendNameservers = [ "1.1.1.1" "8.8.8.8" ];

      #--------------------------------------------------------------------- 
      # Prevent fragmentation and reassembly, which can improve network performance
      #---------------------------------------------------------------------
      connectionConfig = {
        "ethernet.mtu" = 1462;
        "wifi.mtu" = 1462;
      };

    };

    timeServers = [
      "0.nixos.pool.ntp.org"
      "1.nixos.pool.ntp.org"
      "2.nixos.pool.ntp.org"
      "3.nixos.pool.ntp.org"
      "time.google.com"
      "time2.google.com"
      "time3.google.com"
      "time4.google.com"
    ];

    # defaultGateway = "192.168.0.1";
    # interfaces.enp3s0.ipv4.addresses = [{
    #  address = "192.168.0.13";
    #  prefixLength = 24;
    # }];

    # terminal: arp -a
    extraHosts = ''
      192.168.0.1     router
      192.168.0.2     DIGA            # Smart TV
      192.168.0.6     iPhone          # Dads mobile
      192.168.0.7     Laser           # Laser Printer
      192.168.0.8     min21THIN       # EMMC thinClient
      192.168.0.10    TUNCAY-W11-ENT  # Dads PC
      192.168.0.11    ubuntu-server   # CasaOS
      192.168.0.13    HP-G800         # Main NixOS rig
      192.168.0.15    KingTolga       # My mobile
      192.168.0.20    W11-SERVER      # Main home server
    '';

  };
  # Install network time protocol
  environment.systemPackages = with pkgs; [ ntp ];

  # Wifi network monitor connector
  services.dbus.packages = [ pkgs.miraclecast ];
}

# wireless = {
      # via wpa_supplicant.
#      enable = false;
#      iwd = {
#        enable = false;
 #       settings = {
#          Network = {
#            EnableIPv6 = true;
#            RoutePriorityOffset = 300;
#          };
 #         Settings = {
  #          AutoConnect = true;
 #         };
 #       };
#      };
#    };
    ## Configure network proxy if necessary.
    # proxy = {
    #   default = "http://user:password@proxy:port/";
    #   noProxy = "127.0.0.1,localhost,internal.domain";
    # };
#  };

