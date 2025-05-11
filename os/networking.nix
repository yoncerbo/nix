{
  networking = {
    hostName = "laptop";
    networkmanager.enable = true;
    useDHCP = true;
    # firewall.allowedTCPPorts = [ 8080 80 443 ];
    firewall.enable = true;
  };
}
