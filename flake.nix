{
  description = "";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    zen-browser.url = "github:MarceColl/zen-browser-flake";
    zen-browser.inputs.nixpkgs.follows = "nixpkgs";
    # osu.url = "github:notgne2/osu-nixos";
    # osu.inputs.nixpkgs.follows = "nixpkgs";
  };
  outputs = { self, nixpkgs, home-manager, zen-browser, ... }: {
    nixosConfigurations.nix = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        home-manager.nixosModules.home-manager
        ./system.nix
        ./hardware-configuration.nix
        ./os
        {
          environment.systemPackages = [zen-browser.packages.x86_64-linux.default];
          # nixpkgs.overlays = [ osu.overlay ];
        }
      ];
    };
    homeConfigurations.m = home-manager.lib.homeManagerConfiguration {
      pkgs = nixpkgs.legacyPackages.x86_64-linux;
      modules = [
        ./home.nix
      ];
    };
  };
}
