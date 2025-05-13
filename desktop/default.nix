{ pkgs, lib, config, zen-browser, inputs, ... }: {
  includes = [
    ./hardware-configuration.nix
    # ./wordpress.nix
    ./tablet.nix
    ./fonts.nix
    ./audio.nix
    ./bluetooth.nix
    ./localization.nix
    # ./waydroid.nix
    ./kanata.nix
    # ./keyd.nix
    ./localization.nix
    ./mounts.nix
    ./sudo.nix
    ./networking.nix
  ];

  home-manager.users.m = ../home/desktop.nix;
  home-manager.backupFileExtension = "backup";

  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    neovim
    home-manager
    git
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
}
