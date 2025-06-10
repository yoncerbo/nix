{
  security.sudo.wheelNeedsPassword = false;
  security.sudo.extraRules = [{
    groups = [ "wheel" ];
    commands = [
      {
        command = "/run/current-system/sw/bin/nixos-rebuild switch";
        options = [ "NOPASSWD" ];
      }
    ];
  }];
}
