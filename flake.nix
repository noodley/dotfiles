{
  description = "NixOS configuration";

  nixConfig = {
    #extra-substituters = [ ];
    #extra-trusted-public-keys = [ ];
  };

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    hardware.url = "github:nixos/nixos-hardware";
    impermanence.url = "github:nix-community/impermanence";
    nix-colors.url = "github:misterio77/nix-colors";
    sops-nix.url = "github:mic92/sops-nix";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs:
    let
      inherit (self) outputs;
      lib = nixpkgs.lib // home-manager.lib;
      systems = [ "x86_64-linux" ];
      forEachSystem = f: lib.genAttrs systems (sys: f pkgsFor.${sys});
      pkgsFor = nixpkgs.legacyPackages;
    in
    {
      inherit lib;
      nixosModules = import ./nix/modules/nixos;
      homeManagerModules = import ./nix/modules/home-manager;
      templates = import ./nix/templates;

      overlays = import ./nix/overlays { inherit inputs outputs; };

      packages = forEachSystem (pkgs: import ./nix/pkgs { inherit pkgs; });
      devShells = forEachSystem (pkgs: import ./nix/shell.nix { inherit pkgs; });
      formatter = forEachSystem (pkgs: pkgs.nixpkgs-fmt);

      nixosConfigurations = {
        # Personal laptop
        e490 = lib.nixosSystem {
          modules = [ ./nix/hosts/e490 ];
          specialArgs = { inherit inputs outputs; };
        };
      };

      homeConfigurations = {
        "dougw@e490" = lib.homeManagerConfiguration {
          modules = [ ./nix/home/dougw/e490.nix ];
          pkgs = pkgsFor.x86_64-linux;
          extraSpecialArgs = { inherit inputs outputs; };
        };
      };
    };
}
