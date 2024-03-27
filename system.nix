{ inputs, lib, config, pkgs, ... }: {
  home-manager = {
    useGlobalPkgs = true; users.m = import ./home.nix;
  };

  systemd.mounts = [
    {
      where = "/etc/NetworkManager/system-connections";
      what = "/f/network-manager";
      wantedBy = [ "multi-user.target" ];
      type = "none";
      options = "bind";
    }
    {
      where = "/etc/machine-id";
      what = "/f/machine-id";
      wantedBy =  [ "multi-user.target" ];
      type = "none";
      options = "bind";
    }
    {
      where = "/etc/keyd/default.conf";
      what = "/f/keyd.ini";
      wantedBy =  [ "multi-user.target" ];
      type = "none";
      options = "bind";
    }
  ];

  environment.systemPackages = with pkgs; [
    neovim
    keyd
    home-manager
  ];
  environment.defaultPackages = lib.mkForce [];

  programs.sway.enable = true;
  programs.adb.enable = true;
  programs.niri.enable = true;

  fonts.packages = with pkgs; [
    (nerdfonts.override { fonts = [ "FiraCode" ]; })
    fira-code
    fira-code-symbols
    noto-fonts-cjk
    noto-fonts-emoji
  ];

  nixpkgs = {
    overlays = [];
    config.allowUnfree = true;
  };

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
    wireless.networks.phone.psk = "12345678";
  };

  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  time.timeZone = "Poland";
  i18n.defaultLocale = "en_US.UTF-8";

  environment.sessionVariables = {
    GTK_IM_MODULE = "fcitx";
    QT_IM_MODULE = "fcitx";
    XMODIFIERS = "@im=fcitx";
    SDL_IM_MODULE = "fcitx";
    GLFW_IM_MODULE = "ibus";
    QT_QPA_PLATFORM = "wayland";
  };

  virtualisation = {
    waydroid.enable = false;
    lxd.enable = false;
  };

  sound.enable = true;
  hardware = {
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
      hashedPasswordFile = "/nix/persist/secrets/password";
      shell = pkgs.dash;
    };
    mutableUsers = false;
  };

  security = {
    # sudo.enable = false;
    doas = {
      enable = true;
    };
  };

  programs.zsh.enable = true;

  services.thermald.enable = true;

  users.groups.keyd = {};
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

  services.xserver.libinput.enable = true;

  # xdg.portal.wlr.enable = true;

  boot.kernelModules = [ "kvm-amd" ];
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
  networking.useDHCP = lib.mkDefault true;

  system.stateVersion = "23.11";
}
