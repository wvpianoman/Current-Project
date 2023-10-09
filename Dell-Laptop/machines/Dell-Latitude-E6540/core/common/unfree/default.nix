{ config, pkgs, ... }:

{

  #---------------------------------------------------------------------
  #   Allow unfree packages
  #---------------------------------------------------------------------
  environment.sessionVariables.NIXPKGS_ALLOW_UNFREE = "1";
  nixpkgs.config.permittedInsecurePackages = [ "openssl-1.1.1u" "electron-12.2.3" ];

}
