{ pkgs, lib, config, zen-browser, inputs, ... }: {
  imports = [
    ./hardware-configuration/desktop.nix
    # ./wordpress.nix
    ./tablet.nix
    ./fonts.nix
    ./audio.nix
    ./bluetooth.nix
    ./localization.nix
    # ./waydroid.nix
    # ./kanata.nix
    # ./keyd.nix
    ./mounts.nix
    ./networking.nix
    ./keyboard.nix
    ./vr.nix
    ./syncthing.nix
    ./openrgb.nix
    ./ssh.nix
    ./nextcloud.nix
  ];

  networking.hostName = "desktop";

  home-manager.users.m = ../home/desktop.nix;
  home-manager.backupFileExtension = "backup";

  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    neovim
    home-manager
    git
    via # qmk
    vial
    lact # gpu controller
  ];
  environment.defaultPackages = lib.mkForce [];

  programs = {
    thunar.enable = true;
    steam.enable = true;
  };

  nixpkgs.overlays = [];

  nix = {
    settings = {
      allowed-users = [ "m" ];
      experimental-features = "nix-command flakes";
      auto-optimise-store = true;
      trusted-users = [ "root" "m" ];
    };
  };

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelPackages = pkgs.linuxPackages_latest;

  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    QT_QPA_PLATFORM = "wayland";
  };

  users = {
    users.m = {
      extraGroups = [ 
        "wheel" "audio" "video" "uinput" "input" "networkmanager" "kvm" "adbusers"
        "dialout" # tty stuff
      ];
      isNormalUser = true;
      # sudo mkpasswd -m sha-512 "password"
      hashedPassword = "$6$/5al5la2aDXWmNiQ$IRfje.1DyTG4RsvhLZSgWz8qlLrN98BvgofrX0WfABZPo6SiOXh5n3JNezltNOBJDYYeJgr9CjyQpZ3Z8BK3R1";
      shell = pkgs.dash;
    };
    mutableUsers = false;
  };

  services.libinput.enable = true;

  powerManagement.enable = true;
  services.thermald.enable = true;
  services.tlp.enable = true;

  xdg.portal.wlr.enable = true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";

  system.stateVersion = "23.11";

  hardware.graphics.enable = true;
  hardware.graphics.enable32Bit = true;

  boot.supportedFilesystems = [ "nfs" "ntfs-3g" ];

  fileSystems = lib.mergeAttrsList (builtins.map (dir: {
    "/mnt/${dir}" = {
      device = "192.168.94.150:/${dir}";
      fsType = "nfs";
      options = [ "x-systemd.automount" "noauto" ];
    };
  }) [ "a" "f" "m" "n" "s" "d" ]);

  systemd.services.NetworkManager-wait-online.enable = false;

  boot.loader.timeout = 0;
  boot.loader.systemd-boot.configurationLimit = 32;

  services.greetd = {
    enable =  true;
    settings = rec {
      default_session = {
        user = "m";
        command = "${pkgs.hyprland}/bin/start-hyprland";
        # command = "${pkgs.river}/bin/river";
      };
    };
  };

  # programs.hyprland = {
  #   enable = true;
  #   withUWSM = true;
  # }

  systemd.packages = with pkgs; [ lact ];
  systemd.services.lactd.wantedBy = [ "multi-user.target" ];

  services.sunshine = {
    enable = true;
    autoStart = false;
    capSysAdmin = true;
    openFirewall = true;
  };

  programs.dconf.enable = true; # for home-manager gtk settings

  services.btrfs.autoScrub = {
    enable = true;
    interval = "weekly";
    fileSystems = [ "/" ];
  };

  environment.etc.machine-id.text = "3692bf4d4c5247c6b560a524889d44bc";
  environment.etc."firefox/policies/policies.json".text = ''
  {
    "policies": {
      "AppAutoUpdate": false,
      "DisableAppUpdate": true,
      "ManualAppUpdateOnly": true
    }
  }
  '';

  # For sharing wifi over ethernet using network-manager
  networking.firewall.allowedUDPPorts = [ 53 67 4242 ];

  security.sudo.wheelNeedsPassword = false;

  security.pam.services = {
    login.u2fAuth = true;
    sudo.u2fAuth = true;
    greetd.u2fAuth = true;
    hyprlock.u2fAuth = true;
  };

  programs.appimage = {
    enable = true;
    binfmt = true;
  };

  programs.appimage.package = pkgs.appimage-run.override {
    extraPkgs = pkgs: [
      pkgs.icu
    ];
  };

  programs.kdeconnect = {
    enable = true;
  };

  services.udisks2.enable = true;

  # services.suwayomi-server.enable = true;
  # services.suwayomi-server.settings.server.port = 4567;
  # services.suwayomi-server.settings.server.ip = "192.168.232.183";
  # services.suwayomi-server.openFirewall = true;
}
