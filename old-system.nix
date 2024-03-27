{ inputs, lib, config, pkgs, ... }:
let
  mkBinds = opts: where: what: lib.mapAttrsToList (k: v: {
    where = where + k;
    what = what + v;
    type = "none";
    options = "bind";
  } // opts );

  systemBinds = {
    "NetworkManager/system-connections" = "nm-connections";
    machine-id = "machine-id";
    # keyd = "keyd.ini";
  };

  configBinds = {
    # qutebrowser = "qutebrowser";
    nushell = "nushell";
  };

  dataBinds = {
    # qutebrowser = "qutebrowser";
  };
  
in {
  home-manager = {
    useGlobalPkgs = true;
    users.m = import ./home.nix;
  };

  environment.systemPackages = with pkgs; [
    neovim
    keyd
    home-manager
  ];
  environment.defaultPackages = lib.mkForce [];

  programs.sway.enable = true;
  programs.adb.enable = true;

  fonts.fonts = with pkgs; [
    (nerdfonts.override { fonts = [ "FiraCode" ]; })
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
  ];

  nixpkgs = {
    overlays = [];
    # config.allowUnfree = true;
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
      passwordFile = "/nix/persist/secrets/password";
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
  environment.etc.keyd.text = ''
  '';

  systemd.mounts = let
    systemOptions = {
      wantedBy = [ "multi-user.target" ]; # after boot
    };
    userOptions = {
      after = [ "home-manager-m.service" ];
      wantedBy = [ "multi-user.target" ];
    };
  in (mkBinds systemOptions "/etc/" "/app/" systemBinds) ++
  (mkBinds userOptions "/home/m/.config/" "/app/" configBinds) ++
  (mkBinds userOptions "/home/m/.local/share/" "/app/" dataBinds);

  services.xserver.libinput.enable = true;

  # xdg.portal.wlr.enable = true;

  boot.kernelModules = [ "kvm-amd" ];
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
  networking.useDHCP = lib.mkDefault true;

  system.stateVersion = "23.11";
}
