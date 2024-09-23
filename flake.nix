{
  description = "Flake of Andreas";

  inputs = {
    nixpkgs = {
      url = "nixpkgs/nixos-unstable";
    };

    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixos-cosmic = {
      url = "github:lilyinstarlight/nixos-cosmic";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    alejandra = {
      url = "github:kamadorueda/alejandra";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix = {
      url = "github:danth/stylix";
    };

    blocklist-hosts = {
      url = "github:StevenBlack/hosts";
      flake = false;
    };

    hyprland-plugins = {
      url = "github:hyprwm/hyprland-plugins";
      flake = false;
    };

    nixos-hardware = {
      url = "github:NixOS/nixos-hardware";
    };
  };

  outputs = {
    nixpkgs,
    home-manager,
    alejandra,
    ...
  } @ inputs: let
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

    # Configure pkgs
    pkgs = import nixpkgs {
      inherit system;
      config = {
        allowUnfree = true;
      };
    };

    # Configure lib
    inherit (nixpkgs) lib;

    # Helper function to apply DRY to nixosConfigurations
    mkNixosLaptop = {
      hostname,
      hostConfigPath,
      additionalModules ? [],
      ...
    }:
      lib.nixosSystem {
        inherit system;
        modules = [
          # Host-specific configuration
          hostConfigPath

          # Always install alejandra linter
          {
            environment.systemPackages = [alejandra.defaultPackage.${system}];
          }

          # Cosmic Desktop Settings
          {
            nix.settings = {
              substituters = ["https://cosmic.cachix.org/"];
              trusted-public-keys = ["cosmic.cachix.org-1:Dya9IyXD4xdBehWjrkPv6rtxpmMdRel02smYzA85dPE="];
            };
          }
          inputs.nixos-cosmic.nixosModules.default

        ] ++ additionalModules; # option to add different modules per host.
        specialArgs = {
          inherit (inputs) blocklist-hosts stylix sops-nix;
          inherit hostname font fontPkg locale name sshkey_public theme timezone username wm;
        };
      };
  in {
    homeConfigurations = {
      andreas = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [./users/andreas/home.nix];
        extraSpecialArgs = {
          inherit (inputs) hyprland-plugins stylix sops-nix;
          inherit browser editor email font fontPkg name spawnEditor term theme timezone username wm wmType;
        };
      };

      romy = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [./users/romy/home.nix];
        extraSpecialArgs = {
          username = "romy";
          email = "romy@ros.land";
          name = "Romy";
          wm = "gnome";
          inherit (inputs) hyprland-plugins stylix;
          inherit editor font fontPkg spawnEditor term theme timezone wmType;
        };
      };
    };

    nixosConfigurations = {
      phantom = mkNixosLaptop {
        hostname = "phantom";
        hostConfigPath = ./hosts/phantom/configuration.nix;
        additionalModules = [ inputs.nixos-hardware.nixosModules.lenovo-thinkpad-t480 ];
      };

      hypoxic = mkNixosLaptop {
        hostname = "hypoxic";
        hostConfigPath = ./hosts/hypoxic/configuration.nix;
        additionalModules = [ inputs.nixos-hardware.nixosModules.lenovo-thinkpad-x1-extreme-gen4 ];
      };

    };
  };
}
