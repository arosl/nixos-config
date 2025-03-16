{
  description = "Flake of Andreas";

  inputs = {
    nixpkgs = {
      url = "nixpkgs/nixos-unstable";
    };

    # New input for the wcslib patch PR:
    # wcslib-patch = {
    #   url = "github:NixOS/nixpkgs/pull/380492/head";
    # };
    nixpkgs-master = {
      url = "nixpkgs/master";
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
    catppuccin = {
      url = "github:catppuccin/nix";
    };
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, nixpkgs-master, catppuccin, home-manager, alejandra, ... } @ inputs: let
    # ---- SYSTEM SETTINGS ---- #
    locale = "en_US.UTF-8";
    sshkey_public = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIK9WYZgphn4uQ5ZqBkTwbSIk2htGe74EiANdItjgWlrM andreas@ros.land";
    system = "x86_64-linux";
    timezone = "America/Cancun";

    # Configure pkgs with the overlay that overrides wcslib.
    pkgs = import nixpkgs {
      inherit system;
      config = {
        allowUnfree = true;
      };
      overlays = [
        (final: prev: {
          # Use legacyPackages because the PR doesn't export "packages"
          wcslib = (nixpkgs-master.legacyPackages.${system}).wcslib;
        })
      ];
    };

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

    # Configure lib
    inherit (nixpkgs) lib;

    # Helper function to DRY up nixosConfigurations
    mkNixosLaptop = {
      hostname,
      hostConfigPath,
      additionalModules ? [],
      ...
    }:
      lib.nixosSystem {
        inherit system;
        modules =
          [
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
                trusted-public-keys = [
                  "cosmic.cachix.org-1:Dya9IyXD4xdBehWjrkPv6rtxpmMdRel02smYzA85dPE="
                ];
              };
            }

            # Cosmic module
            inputs.nixos-cosmic.nixosModules.default

            # Catppuccin NixOS module
            inputs.catppuccin.nixosModules.catppuccin
          ]
          ++ additionalModules; # Option to add different modules per host.

        specialArgs = {
          inherit (inputs) blocklist-hosts stylix sops-nix;
          inherit
            font
            fontPkg
            hostname
            locale
            name
            sshkey_public
            theme
            timezone
            username
            wm;
        };
      };
  in {
    homeConfigurations = {
      andreas = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [
          ./users/andreas/home.nix
          inputs.catppuccin.homeManagerModules.catppuccin
          inputs.nixvim.homeManagerModules.nixvim
        ];
        extraSpecialArgs = {
          inherit (inputs) hyprland-plugins stylix sops-nix;
          inherit
            browser
            editor
            email
            font
            fontPkg
            name
            spawnEditor
            term
            theme
            timezone
            username
            wm
            wmType;
        };
      };

      romy = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [
          ./users/romy/home.nix
          # Add Catppuccin for Romy:
          # inputs.catppuccin.homeManagerModules.catppuccin
        ];
        extraSpecialArgs = {
          username = "romy";
          email = "romy@ros.land";
          name = "Romy";
          wm = "gnome";
          inherit (inputs) hyprland-plugins stylix;
          inherit
            editor
            font
            fontPkg
            spawnEditor
            term
            theme
            timezone
            wmType;
        };
      };
    };

    nixosConfigurations = {
      phantom = mkNixosLaptop {
        hostname = "phantom";
        hostConfigPath = ./hosts/phantom/configuration.nix;
        additionalModules = [
          inputs.nixos-hardware.nixosModules.lenovo-thinkpad-t480
        ];
      };

      hypoxic = mkNixosLaptop {
        hostname = "hypoxic";
        hostConfigPath = ./hosts/hypoxic/configuration.nix;
        additionalModules = [
          inputs.nixos-hardware.nixosModules.lenovo-thinkpad-x1-extreme-gen4
        ];
      };
    };
  };
}
