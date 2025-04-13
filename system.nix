{ pkgs, lib, config, zen-browser, inputs, ... }: {
  home-manager.users.m = ./home.nix;
  home-manager.backupFileExtension = "backup";
  # home-manager.backupFileExtension = "backup";

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

  hardware.opentabletdriver.enable = true;
  hardware.opentabletdriver.daemon.enable = true;

  nixpkgs.config.allowUnfree = true;

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

  systemd.mounts = [
    {
      where = "/etc/NetworkManager/system-connections";
      what = "/a/network-manager";
      wantedBy = [ "multi-user.target" ];
      type = "none";
      options = "bind";
    }
    {
      where = "/etc/machine-id";
      what = "/a/machine-id";
      wantedBy =  [ "multi-user.target" ];
      type = "none";
      options = "bind";
    }
    {
      where = "/etc/nixos/";
      what = "/d/nix";
      wantedBy =  [ "multi-user.target" ];
      type = "none";
      options = "bind";
    }
    {
      where = "/var/lib/systemd";
      what = "/a/systemd/";
      wantedBy = [ "boot.target" ];
      type = "none";
      options = "bind";
    }
  ];

  environment.systemPackages = with pkgs; [
    neovim
    home-manager
    git

    (steam.override { extraPkgs = pkgs: [
      zlib
      gcc
      libsForQt5.qtbase
      libsForQt5.qtwayland
    ]; }).run
  ];
  environment.defaultPackages = lib.mkForce [];

  programs = {
    # sway.enable = true;
    thunar.enable = true;
    adb.enable = true;
    # niri.enable = true;
    steam.enable = true;
    # hyprland.enable = true;
    nix-ld.enable = true;
    nix-ld.libraries = with pkgs; [
      zlib
      gcc
      libsForQt5.qtbase
      libsForQt5.qtwayland
    ];
  };

  fonts.packages = with pkgs; [
    nerd-fonts.fira-code
    fira-code
    fira-code-symbols
    noto-fonts-emoji
    noto-fonts-cjk-sans
    noto-fonts-emoji

    liberation_ttf
    mplus-outline-fonts.githubRelease
    dina-font
    proggyfonts
  ];

  nixpkgs.overlays = [];

  nix = {
    settings = {
      allowed-users = [ "m" ];
      experimental-features = "nix-command flakes";
      auto-optimise-store = true;
    };
    # gc
  };

  networking = {
    hostName = "nix";
    networkmanager.enable = true;
    # wireless.networks.phone.psk = "";
  };

  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  boot.kernelPackages = pkgs.linuxPackages_latest;

  time.timeZone = "Poland";
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.supportedLocales = [
    "C.UTF-8/UTF-8"
    "en_US.UTF-8/UTF-8"
    "ja_JP.UTF-8/UTF-8"
    "pl_PL.UTF-8/UTF-8"
  ];

  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    GTK_IM_MODULE = "fcitx";
    QT_IM_MODULE = "fcitx";
    XMODIFIERS = "@im=fcitx";
    SDL_IM_MODULE = "fcitx";
    GLFW_IM_MODULE = "ibus";
    QT_QPA_PLATFORM = "wayland";
  };

  i18n.inputMethod = {
    enabled = "fcitx5";
    fcitx5.addons = with pkgs; [
      libsForQt5.fcitx5-qt
      fcitx5-gtk
      fcitx5-mozc # japanese
      fcitx5-hangul # korean
      fcitx5-chinese-addons
      fcitx5-rime # chinese
      fcitx5-m17n
      fcitx5-table-other
      fcitx5-configtool
    ];
  };

  virtualisation = {
    waydroid.enable = true;
    # lxd.enable = true;
  };

  hardware = {
    # alsa.enablePersistence = true;
    pulseaudio.enable = true;
    bluetooth.enable = true;
  };
  # For bluetooth support
  # hardware.pulseaudio.package = pkgs.pulseaudioFull;

  users = {
    users.m = {
      extraGroups = [ "wheel" "audio" "video" "uinput" "input" "networkmanager" ];
      isNormalUser = true;
      # sudo mkpasswd -m sha-512 "password"
      hashedPassword = "$6$/5al5la2aDXWmNiQ$IRfje.1DyTG4RsvhLZSgWz8qlLrN98BvgofrX0WfABZPo6SiOXh5n3JNezltNOBJDYYeJgr9CjyQpZ3Z8BK3R1";

      # empty password
      # hashedPassword = "$6$bjLWirn7JLJbMKso$DVheozeraNVCbFR6iSwMbx3214od0bYrSuKYRSOZ0X/B4MGGS/0vTJWILBPJ/dPDF7V50/joyZ1n8ira1Vl36.";
      shell = pkgs.dash;
    };
    mutableUsers = false;
  };

  security = {
    # sudo.enable = false;
    doas = {
      # enable = true;
    };
  };

  security.sudo.extraRules = [{
    groups = [ "wheel" ];
    commands = [
      {
        command = "/run/current-system/sw/bin/nixos-rebuild switch";
        options = [ "NOPASSWD" ];
      }
    ];
  }];


  # systemd.services.onshutdown = {
  #   description = "runs before system shutdown";
  #   wantedBy = [ "shutdown.target" ];
  #   before = [ "shutdown.target" ];
  #   script = ''
  #   echo "hello" > /f/shutdown
  #   # ${pkgs.brightnessctl}/bin/brightnessctl get > /f/brightness
  #   '';
  #   serviceConfig = {
  #     Type = "oneshot";
  #     TimeoutStartSec = 0;
  #   };
  # };

  services.libinput.enable = true;

  powerManagement.enable = true;
  services.thermald.enable = true;
  services.tlp.enable = true;

  services.kanata = {
    enable = true;
    keyboards.main.extraDefCfg = ''
      movemouse-inherit-accel-state yes
      log-layer-changes no
    '';
    keyboards.main.devices = [ "/dev/input/event0" "/dev/input/by-id/usb-30fa_USB_Optical_Mouse-event-mouse" ];
    keyboards.main.config = builtins.readFile ./kanata.kbd;
  };

  # systemd.services.kanata = {
  #   wantedBy = [ "multi-user.target" ];
  #   serviceConfig = {
  #     Type = "notify";
  #     ExecStart = "${pkgs.kanata}/bin/kanata --cfg /d/kanata.kbd";
  #   };
  # };

  # users.groups.keyd = {};
  # systemd.services.keyd = {
  #   enable = true;
  #   description = "key remapping deamon";
  #   serviceConfig = {
  #     Type = "simple";
  #     ExecStart = "${pkgs.keyd}/bin/keyd";
  #   };
  #   wantedBy = [ "sysinit.target" ];
  #   requires = [ "local-fs.target" ];
  #   after = [ "local-fs.target" ];
  # };

  xdg.portal.wlr.enable = true;

  boot.kernelModules = [ "kvm-amd" ];
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
  networking.useDHCP = lib.mkDefault true;

  # networking.firewall.allowedTCPPorts = [ 8080 80 443 ];
  networking.firewall.enable = false;

  system.stateVersion = "23.11";
}
