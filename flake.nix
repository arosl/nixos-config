{
  description = "Flake of Andreas";

  outputs = { self, nixpkgs, home-manager, alejandra, stylix, blocklist-hosts, hyprland-plugins, sops-nix, ... } @ inputs:
    let
      # ---- SYSTEM SETTINGS ---- #
      locale = "en_US.UTF-8";
      sshkey_public = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIK9WYZgphn4uQ5ZqBkTwbSIk2htGe74EiANdItjgWlrM andreas@ros.land";
      system = "x86_64-linux";
      timezone = "America/Cancun";

      # ----- DEFAULT USER SETTINGS ----- #
      browser = "chromium";
      editor = "nvim";
      email = "andreas@ros.land";
      font = "Intel One Mono";
      fontPkg = pkgs.intel-one-mono;
      name = "Andreas";
      spawnEditor = "nvim";
      term = "alacritty";
      theme = "catppuccin-mocha";
      username = "andreas";
      wm = "hyprland";
      wmType = "wayland";

      # configure pkgs
      pkgs = import nixpkgs {
        inherit system;
        config = {
          allowUnfree = true;
        };
      };

      # configure lib
      lib = nixpkgs.lib;
    in {
      homeConfigurations = {
        andreas = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [ ./users/andreas/home.nix ];
          extraSpecialArgs = {
            inherit theme;
            inherit timezone;
            inherit (inputs) stylix;
            inherit (inputs) hyprland-plugins;
            username = "andreas";
            browser = "chromium";
            editor = "nvim";
            email = "andreas@ros.land";
            font = "Intel One Mono";
            fontPkg = pkgs.intel-one-mono;
            name = "Andreas";
            spawnEditor = "nvim";
            term = "alacritty";
            wm = "hyprland";
            wmType = "wayland";
          };
        };

        romy = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [ ./users/romy/home.nix ];
          extraSpecialArgs = {
            inherit theme;
            inherit timezone;
            inherit (inputs) stylix;
            inherit (inputs) hyprland-plugins;
            username = "romy";
            editor = "nvim";
            email = "";
            font = "Intel One Mono";
            fontPkg = pkgs.intel-one-mono;
            name = "romy";
            spawnEditor = "nvim";
            term = "alacritty";
            wm = "gnome";
            wmType = "wayland";
          };
        };
      };

      nixosConfigurations = {
        phantom = lib.nixosSystem {
          inherit system;
          modules = [
            ./hosts/phantom/configuration.nix
            {
              environment.systemPackages = [ alejandra.defaultPackage.${system} ];
            }
            # Remove romy's Home Manager from here
          ];
          specialArgs = {
            hostname = "phantom";
            inherit username;
            inherit name;
            inherit timezone;
            inherit locale;
            inherit theme;
            inherit font;
            inherit fontPkg;
            inherit wm;
            inherit sops-nix;
            inherit sshkey_public;
            inherit (inputs) stylix;
            inherit (inputs) blocklist-hosts;
          };
        };

        hypoxic = lib.nixosSystem {
          inherit system;
          modules = [
            ./hosts/hypoxic/configuration.nix
            {
              environment.systemPackages = [ alejandra.defaultPackage.${system} ];
            }
            # Remove romy's Home Manager from here
          ];
          specialArgs = {
            hostname = "hypoxic";
            inherit username;
            inherit name;
            inherit timezone;
            inherit locale;
            inherit theme;
            inherit font;
            inherit fontPkg;
            inherit wm;
            inherit sops-nix;
            inherit sshkey_public;
            inherit (inputs) stylix;
            inherit (inputs) blocklist-hosts;
          };
        };
      };
    };

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";

    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    alejandra.url = "github:kamadorueda/alejandra";
    alejandra.inputs.nixpkgs.follows = "nixpkgs";

    sops-nix.url = "github:Mic92/sops-nix";
    sops-nix.inputs.nixpkgs.follows = "nixpkgs";

    stylix.url = "github:danth/stylix";
    blocklist-hosts = {
      url = "github:StevenBlack/hosts";
      flake = false;
    };
    hyprland-plugins = {
      url = "github:hyprwm/hyprland-plugins";
      flake = false;
    };
  };
}
