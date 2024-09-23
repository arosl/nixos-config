{
  description = "Flake of Andreas";

  outputs = {
    nixpkgs,
    home-manager,
    alejandra,
    sops-nix,
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
  in {
    homeConfigurations = {
      andreas = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [./users/andreas/home.nix];
        extraSpecialArgs = {
          inherit (inputs) hyprland-plugins;
          inherit (inputs) stylix;
          inherit (inputs) sops-nix;
          inherit browser;
          inherit editor;
          inherit email;
          inherit font;
          inherit fontPkg;
          inherit name;
          inherit spawnEditor;
          inherit term;
          inherit theme;
          inherit timezone;
          inherit username;
          inherit wm;
          inherit wmType;
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
          inherit (inputs) hyprland-plugins;
          inherit (inputs) stylix;
          inherit editor;
          inherit font;
          inherit fontPkg;
          inherit spawnEditor;
          inherit term;
          inherit theme;
          inherit timezone;
          inherit wmType;
        };
      };
    };

    nixosConfigurations = {
      phantom = lib.nixosSystem {
        inherit system;
        modules = [
          ./hosts/phantom/configuration.nix
          {
            environment.systemPackages = [alejandra.defaultPackage.${system}];
          }
          # Include the hardware module for phantom
          inputs.nixos-hardware.nixosModules.lenovo-thinkpad-t480
          #cosmic desktop
          {
            nix.settings = {
              substituters = ["https://cosmic.cachix.org/"];
              trusted-public-keys = ["cosmic.cachix.org-1:Dya9IyXD4xdBehWjrkPv6rtxpmMdRel02smYzA85dPE="];
            };
          }
          inputs.nixos-cosmic.nixosModules.default
        ];
        specialArgs = {
          hostname = "phantom";
          inherit (inputs) blocklist-hosts;
          inherit (inputs) stylix;
          inherit font;
          inherit fontPkg;
          inherit locale;
          inherit name;
          inherit sops-nix;
          inherit sshkey_public;
          inherit theme;
          inherit timezone;
          inherit username;
          inherit wm;
        };
      };

      hypoxic = lib.nixosSystem {
        inherit system;
        modules = [
          ./hosts/hypoxic/configuration.nix
          {
            environment.systemPackages = [alejandra.defaultPackage.${system}];
          }
          # Include the hardware module for hypoxic
          inputs.nixos-hardware.nixosModules.lenovo-thinkpad-x1-extreme-gen4
          #cosmic desktop
          {
            nix.settings = {
              substituters = ["https://cosmic.cachix.org/"];
              trusted-public-keys = ["cosmic.cachix.org-1:Dya9IyXD4xdBehWjrkPv6rtxpmMdRel02smYzA85dPE="];
            };
          }
          inputs.nixos-cosmic.nixosModules.default
        ];
        specialArgs = {
          hostname = "hypoxic";
          inherit (inputs) blocklist-hosts;
          inherit (inputs) stylix;
          inherit font;
          inherit fontPkg;
          inherit locale;
          inherit name;
          inherit sops-nix;
          inherit sshkey_public;
          inherit theme;
          inherit timezone;
          inherit username;
          inherit wm;
        };
      };
    };
  };

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

    stylix.url = "github:danth/stylix";

    blocklist-hosts = {
      url = "github:StevenBlack/hosts";
      flake = false;
    };

    hyprland-plugins = {
      url = "github:hyprwm/hyprland-plugins";
      flake = false;
    };

    nixos-hardware.url = "github:NixOS/nixos-hardware";
  };
}
