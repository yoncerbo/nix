{ pkgs, ... }: {
  users.groups.keyd = {};

  systemd.services.keyd = {
    enable = true;
    description = "key remapping deamon";
    serviceConfig = {
      Type = "simple";
      ExecStart = "${pkgs.keyd}/bin/keyd";
    };
    wantedBy = [ "sysinit.target" ];
    requires = [ "local-fs.target" ];
    after = [ "local-fs.target" ];
  };

}
