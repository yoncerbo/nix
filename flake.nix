{
  description = "";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # zen-browser = {
    #   url = "github:youwen5/zen-browser-flake";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };
    glaumar.url = "github:glaumar/nur";
    glaumar.inputs.nixpkgs.follows = "nixpkgs";
    # osu.url = "github:notgne2/osu-nixos";
    # osu.inputs.nixpkgs.follows = "nixpkgs";
  };
  outputs = { self, nixpkgs, home-manager, ... }@inputs: {
    nixosConfigurations.laptop = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        home-manager.nixosModules.home-manager
        ./os/laptop.nix
      ];
    };
    nixosConfigurations.desktop = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        {
          environment.systemPackages = [
            # inputs.zen-browser.packages.x86_64-linux.default
          ];
        }
        home-manager.nixosModules.home-manager
        ./os/desktop.nix
      ];
    };
    homeConfigurations.desktop = home-manager.lib.homeManagerConfiguration {
      pkgs = nixpkgs.legacyPackages.x86_64-linux;
      modules = [
        {
          nixpkgs.overlays = [
            (final: prev: {
              glaumar = inputs.glaumar.packages."${prev.system}";
            })
          ];
        }
        ./home/desktop.nix
      ];
    };
    homeConfigurations.laptop = home-manager.lib.homeManagerConfiguration {
      pkgs = nixpkgs.legacyPackages.x86_64-linux;
      modules = [
        ./home/laptop.nix
      ];
    };
  };
}
