{ pkgs, ... }: {
  environment.systemPackages = [ pkgs.wp-cli ];

  # https://discourse.nixos.org/t/tutorial-for-setting-up-the-lamp-stack-on-a-nixos-server/12508/4
  services.httpd = {
    enable = true;
    adminAddr = "meersehn@proton.me";
    enablePHP = true;
    virtualHosts.localhost.documentRoot = "/f/wordpress";
    extraConfig = ''
      DirectoryIndex index.html index.php
    '';
  };

  # https://wiki.nixos.org/wiki/PHP
  services.httpd.phpPackage = pkgs.php.buildEnv {
    extraConfig = ''
      upload_max_filesize=1G
      post_max_size=1G
    '';
  };

  services.mysql = {
    enable = true;
    package = pkgs.mariadb;
    dataDir = "/a/mysql";
  };

  # services.nginx.enable = true;
  # services.nginx.virtualHosts.localhost = {
  #   addSSL = false;
  #   root = "/f/wordpress";
  #   locations."~ \\.php$".extraConfig = ''
  #     fastcgi_pass unix:${config.services.phpfpm.pools.mypool.socket};
  #     fastcgi_index index.php;
  #   '';
  # };

  # services.phpfpm.pools.mypool = {
  #   user = "nobody";
  #   settings = {
  #     "pm" = "dynamic";
  #     "listen.owner" = config.services.nginx.user;
  #     "pm.max_children" = 5;
  #     "pm.start_servers" = 2;
  #     "pm.min_spare_servers" = 1;
  #     "pm.max_spare_servers" = 3;
  #     "pm.max_requests" = 500;
  #   };
  # };

}
