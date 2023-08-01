{
  description = "Zijun's system configurations";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    # nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-23.05";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    spicetify-nix.url = "github:wine99/spicetify-nix";
  };

  outputs = inputs@{ self, nixpkgs, home-manager, spicetify-nix, ... }:
    let
      system = "x86_64-linux";
      user = "zijun";
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
        # overlays = [
        #   self.overlays.default
        # ];
      };
      # selfPkgs = import ./pkgs;
      specialArgs = inputs // { inherit system user; };
    in
    {
      # overlays.default = selfPkgs.overlay;
      devShells.${system}.default = import ./shell.nix { inherit pkgs; };
      formatter.${system} = pkgs.nixpkgs-fmt;
      nixosConfigurations = {
        y7000 = nixpkgs.lib.nixosSystem {
          inherit system;
          inherit specialArgs;

          modules = [
            ./hosts/y7000

            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;

              home-manager.extraSpecialArgs = specialArgs;
              home-manager.users.${user} = import ./home;
            }
          ];
        };
      };
    };
}
