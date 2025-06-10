{
  services.syncthing = {
    enable = true;
    user = "m";
    dataDir = "/f/sync";
    configDir = "/a/syncthing";
  };

  networking.firewall.allowedTCPPorts = [ 8384 22000 ];
  networking.firewall.allowedUDPPorts = [ 22000 21027 ];
}
