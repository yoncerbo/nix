      fsType = "none";
      options = [ "bind" ];
    };
    "/s" =  {
      device = "/nix/source/";
      fsType = "none";
      options = [ "bind" ];
    };
    "/n" =  {
      device = "/nix/notes/";
      fsType = "none";
      options = [ "bind" ];
    };
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
      where = "/etc/nixos/";
      what = "/nix/source/nix";
      wantedBy =  [ "multi-user.target" ];
      type = "none";
      options = "bind";
    }
  ];

  environment.systemPackages = with pkgs; [
    neovim
    home-manager
  ];
  environment.defaultPackages = lib.mkForce [];

  programs = {
    # sway.enable = true;
    adb.enable = true;
    niri.enable = true;
    steam.enable = true;
  };

  fonts.packages = with pkgs; [
    (nerdfonts.override { fonts = [ "FiraCode" ]; })
    fira-code
    fira-code-symbols
    noto-fonts-cjk
    noto-fonts-emoji
  ];

  nixpkgs.config.allowUnfree = true;
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

  time.timeZone = "Poland";
  i18n.defaultLocale = "en_US.UTF-8";

  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
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

  hardware = {
    pulseaudio.enable = true;
    # bluetooth.enable = true;
  };
  # For bluetooth support
  # hardware.pulseaudio.package = pkgs.pulseaudioFull;

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

  security = {
    # sudo.enable = false;
    doas = {
      enable = true;
    };
  };

services.thermald.enable = true;

systemd.services.kanata = {
  wantedBy = [ "multi-user.target" ];
  serviceConfig = {
    Type = "notify";
    ExecStart = "${pkgs.kanata}/bin/kanata --cfg /s/dot/kanata.kbd";
  };
};

systemd.services.startup = {
  description = "shell script run on system startup";
  wantedBy = [ "multi-user.target" ];
  script = ''
    chgrp video /sys/class/backlight/amdgpu_bl1/brightness
    chmod g+w /sys/class/backlight/amdgpu_bl1/brightness
  '';
};

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

  # services.xserver.libinput.enable = true;
  services.libinput.enable = true;

  xdg.portal.wlr.enable = true;

  boot.kernelModules = [ "kvm-amd" ];
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
  networking.useDHCP = lib.mkDefault true;

  system.stateVersion = "23.11";
}
