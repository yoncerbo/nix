{ pkgs, lib, config, zen-browser, inputs, ... }: {
  imports = [
    ./hardware-configuration/laptop.nix
    ./fonts.nix
    ./audio.nix
    ./bluetooth.nix
    ./localization.nix
    ./mounts.nix
    ./networking.nix
  ];

  networking.hostName = "laptop";

  home-manager.users.m = ../home/laptop.nix;
  home-manager.backupFileExtension = "backup";

  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    neovim
    home-manager
    git
    wayvnc
  ];
  environment.defaultPackages = lib.mkForce [];

  nixpkgs.overlays = [];

  nix = {
    settings = {
      allowed-users = [ "m" ];
      experimental-features = "nix-command flakes";
      auto-optimise-store = true;
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

  i18n.defaultLocale = lib.mkForce "pl_PL.UTF-8/UTF-8";

  security.sudo.wheelNeedsPassword = false;

  services.xserver = {
    enable = true;
    displayManager.gdm.enable = true;
    desktopManager.gnome.enable = true;
  };
}
