{ config, pkgs, lib, ... }: {

  networking = {

    enableIPv6 = true;

    networkmanager.enable = true;

    # Configure firewall to your likings:
    firewall = {
      allowPing = true;

      # I want to configure my own ports
      enable = false;

      #--------------------------------------------------------------------- 
      # Curiously, `services.samba` does not automatically open
      # the needed ports in the firewall. Manualy open ports = [ 139 445 ]
      #--------------------------------------------------------------------- 

      allowedTCPPorts = [
        # Docker
        2375
        # DNS
        53
        # FTP
        21
        # HTTPS
        443
        # HTTP
        80
        # IMAP
        143
        # LDAP
        389
        # MySQL/MariaDB
        3306
        3307
        # NFS
        111
        2049
        # PostgreSQL
        5432
        # Samba
        139
        445
        # SMTP
        25
        # SSH
        22
        # Transmission
        9091
        60450
        # Custom port
        22000
        # For gnomecast server
        80
        8010
        8888
        #wsdd
        5357
        # Open KDE Connect
        {
          from = 1714;
          to = 1764;
        }
      ];

      allowedUDPPorts = [
        # Open KDE Connect
        {
          from = 1714;
          to = 1764;
        }
        # DNS
        53
        # NetBIOS Name Service
        137
        # NetBIOS Datagram Service
        138
        # Custom port
        22000
        # Custom port
        21027
        # For device discovery
        5353
        # wsdd
        3702

      ];

      #--------------------------------------------------------------------- 
      # Adding a rule to the iptables firewall to allow NetBIOS name 
      # resolution traffic on UDP port 137
      #--------------------------------------------------------------------- 

      extraCommands =
        "iptables -t raw -A OUTPUT -p udp -m udp --dport 137 -j CT --helper netbios-ns";

    };
  };
}
