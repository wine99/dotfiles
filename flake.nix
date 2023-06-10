{
  description = "Zijun's system configurations";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-23.05";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    # hyprland.url = "github:hyprwm/Hyprland/v0.25.0";
    hyprland.url = "github:hyprwm/Hyprland";
    # nixpkgs-wayland.url = "github:nix-community/nixpkgs-wayland";
  };

  outputs = inputs@{ self, nixpkgs, home-manager, ... }:
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
    in
    {
      # overlays.default = selfPkgs.overlay;
      devShells.${system}.default = import ./shell.nix { inherit pkgs; };
      formatter.${system} = pkgs.nixpkgs-fmt;
      nixosConfigurations = {
        y7000 = nixpkgs.lib.nixosSystem {
          inherit system;

          # specialArgs = { inherit hyprland user; };
          modules = [
            ./hosts/y7000

            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;

              home-manager.extraSpecialArgs = { inherit inputs system user; };
              home-manager.users.${user} = import ./home;
            }
          ];
        };
      };
    };
}
