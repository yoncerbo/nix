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
    adb.enable = true;
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
      extraGroups = [ "wheel" "audio" "video" "uinput" "input" "networkmanager" ];
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
  hardware.opengl.enable = true;
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
    settings = {
      default_session = {
        user = "m";
        command = "${pkgs.hyprland}/bin/Hyprland";
        # command = "${pkgs.river}/bin/river";
      };
    };
  };

  hardware.graphics.extraPackages = with pkgs; [
    #
  ];

  systemd.packages = with pkgs; [ lact ];
  systemd.services.lactd.wantedBy = [ "multi-user.target" ];

  services.sunshine = {
    enable = true;
    autoStart = true;
    capSysAdmin = true;
    openFirewall = true;
  };

  environment.etc = {
    "xdg/gtk-2.0/grkrc".text = "gtk-error-bell=0";
    "xdg/gtk-3.0/settings.ini".text = ''
      [Settings]
      gtk-error-bell=false
      gtk-applicaiton-prefer-dark-theme=1
    '';
    "xdg/gtk-4.0/settings.ini".text = ''
      [Settings]
      gtk-error-bell=false
      gtk-applicaiton-prefer-dark-theme=1
    '';
  };

  programs.dconf.enable = true; # for home-manager gtk settings

  services.btrfs.autoScrub = {
    enable = true;
    interval = "weekly";
    fileSystems = [ "/" ];
  };

  environment.etc.machine-id.text = "3692bf4d4c5247c6b560a524889d44bc";

  # For sharing wifi over ethernet using network-manager
  networking.firewall.allowedUDPPorts = [ 53 67 ];

  security.sudo.wheelNeedsPassword = false;
}
