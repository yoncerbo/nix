{ lib, ... }: {
  networking = {
    networkmanager.enable = true;
    useDHCP = lib.mkDefault true;
    # firewall.allowedTCPPorts = [ 8080 80 443 ];
    firewall.enable = false;
  };
}
