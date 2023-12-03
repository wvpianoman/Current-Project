{ config, pkgs, lib, inputs, ... }:
let
  # Tolga Erok
  # 30/10/2023
  # samba credentials:  Terminal run ==>   create-smb-user
  #---------------------------------------------------------------------

  # Change to suit
  mySharedPath = "/home/brian/Public"; # Change this path to your desired value

  sharedOptions = {

    # Common options
    "guest ok" = true;
    "read only" = false;

    # Only users with samba in their extraGroup settings can access the following shared folders below HP800_Private && HP800_Public
    "valid users" = "@samba";

    browseable = true;
    writable = true;

  };

in {

  #---------------------------------------------------------------------
  # Samba Configuration - NixOS wiki
  # For a user to be authenticated on the samba server, you must add 
  # their password using sudo smbpasswd -a <user> as root
  #---------------------------------------------------------------------
  services.samba-wsdd.enable = true;

  services.samba = {
    enable = true;

    package = pkgs.samba4Full;
    openFirewall = true;
    securityType = "user";
    extraConfig = ''
      workgroup = WORKGROUP
      server string = 23.05-NixOs_stoat
      netbios name = ${config.networking.hostName}
      name resolve order = bcast host

      # Avoid ipv6 bind errors
      bind interfaces only = yes

      security = user
      hosts allow = 192.168.0. 127.0.0.1 localhost
      hosts deny = 0.0.0.0/0

      vfs objects = catia streams_xattr
      pam password change = yes

      # Set the minimum SMB protocol version on the client end
      # Allow accessing old SMB protocols (SMB1++ = COREPLUS)
      client min protocol = COREPLUS
      aio read size = 0
      aio write size = 0
      vfs objects = acl_xattr catia streams_xattr
      inherit permissions = yes
      # Security
      client ipc max protocol = SMB3

      # SMB2_10
      client ipc min protocol = COREPLUS

      client max protocol = SMB3

      # SMB2_10
      client min protocol = COREPLUS
      server max protocol = SMB3

      # SMB2_10
      server min protocol = COREPLUS

      # Store additional metadata or attributes associated with files or directories on the file system.
      ea support = yes

      # Serving files to Mac clients while maintaining compatibility with macOS-specific features and behaviors
      fruit:metadata = stream
      fruit:model = Macmini
      fruit:veto_appledouble = no
      fruit:posix_rename = yes
      fruit:zero_file_id = yes
      fruit:wipe_intentionally_left_blank_rfork = yes
      fruit:delete_empty_adfiles = yes

      guest account = nobody
      map to guest = bad user

      # printing = cups
      printcap name = cups
      load printers = yes
      cups options = raw
    '';

    shares = {

      sharedOptions = sharedOptions;

      #---------------------------------------------------------------------
      # Home Directories Share - From my old fedora days
      #---------------------------------------------------------------------

      homes = sharedOptions // {
        comment = "Home Directories";
        browseable = false;
        "create mask" = "0700";
        "directory mask" = "0700";
        "valid users" = "%S, %D%w%S";
      };

      #---------------------------------------------------------------------
      # Public Share
      #---------------------------------------------------------------------

      HP800_Public = sharedOptions // {

        path = mySharedPath;
        comment = "Public Share";
        "create mask" = "0777";
        "directory mask" = "0777";

      };

      #---------------------------------------------------------------------
      # Private Share
      #---------------------------------------------------------------------

      HP800_Private = sharedOptions // {

        path = "/home/NixOs";
        comment = "Private Share";
        "create mask" = "0644";
        "directory mask" = "0755";
        "guest ok" = false;

      };

      #---------------------------------------------------------------------
      # Printer Share
      #---------------------------------------------------------------------

      printers = sharedOptions // {

        comment = "All Printers";
        path = "/var/spool/samba";
        public = true;
        writable = false;
        printable = true;
        "create mask" = "0700";

      };
    };

  };

}
