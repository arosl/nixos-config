{
  description = "Flake of Andreas";

  outputs = {
    self,
    nixpkgs,
    home-manager,
    alejandra,
    stylix,
    blocklist-hosts,
    hyprland-plugins,
    sops-nix,
    ...
  } @ inputs: let
    #this all need to be rearanged so i can have muliple user and systems
    # ---- SYSTEM SETTINGS ---- #
    hostname = "hypoxic"; # hostname #FIXME 
    locale = "en_US.UTF-8"; # select locale
    sshkey_public = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIK9WYZgphn4uQ5ZqBkTwbSIk2htGe74EiANdItjgWlrM andreas@ros.land"; # Public sshkey
    system = "x86_64-linux"; # system arch
    timezone = "America/Cancun"; # select timezone

    # ----- DEFAULT USER SETTINGS ----- #
    browser = "chromium"; # Default browser;
    editor = "nvim"; # Default editor;
    email = "andreas@ros.land"; # email (used for certain configurations)
    font = "Intel One Mono"; # Selected font
    fontPkg = pkgs.intel-one-mono; # Font package
    name = "Andreas"; # name/identifier
    spawnEditor = "nvim";
    term = "alacritty"; # Default terminal command;
    theme = "catppuccin-mocha";
    username = "andreas";
    wm = "hyprland"; # Selected window manager or desktop environment
    wmType = "wayland"; # x11 or wayland
    
    # create patched nixpkgs
    # nixpkgs-patched = (import nixpkgs {inherit system;}).applyPatches {
    #   name = "nixpkgs-patched";
    #   src = nixpkgs;
    # };

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
        modules = [./users/andreas/home.nix]; # load home.nix
        extraSpecialArgs = {
          # pass config variables from above
          inherit hostname;
          inherit theme;
          inherit timezone;
          inherit (inputs) stylix;
          inherit (inputs) hyprland-plugins;
          username = "andreas";
          browser = "chromium"; # Default browser;
          editor = "nvim"; # Default editor;
          email = "andreas@ros.land"; # email (used for certain configurations)
          font = "Intel One Mono"; # Selected font
          fontPkg = pkgs.intel-one-mono; # Font package
          name = "Andreas"; # name/identifier
          spawnEditor = "nvim";
          term = "alacritty"; # Default terminal command;
          wm = "hyprland"; # Selected window manager or desktop environment
          wmType = "wayland"; # x11 or wayland
        };
      };
    };
    nixosConfigurations = {
      phantom = lib.nixosSystem {
        inherit system;
        modules = [
          ./hosts/phantom/configuration.nix # load configuration.nix
          {
            environment.systemPackages = [alejandra.defaultPackage.${system}]; #always use the opinionated alejandra formater
          }

          home-manager.nixosModules.home-manager
          {
            home-manager = {
              # useGlobalPkgs = true;
              useUserPackages = true;
              users.romy = import ./users/romy/home.nix;
              extraSpecialArgs = {
                # pass config variables from above
                inherit (inputs) hyprland-plugins;
                inherit (inputs) stylix;
                inherit hostname;
                inherit theme;
                inherit timezone;
                editor = "nvim";
                email = "";
                font = "Intel One Mono"; # Selected font
                fontPkg = pkgs.intel-one-mono; # Font package
                name = "romy";
                spawnEditor = "nvim";
                term = "alacritty"; # Default terminal command;
                username = "romy";
                wm = "gnome"; # Selected window manager or desktop environment
                wmType = "wayland"; # x11 or wayland
              };
            };
          }
        ];
        specialArgs = {
          # pass config variables from above
          inherit username;
          inherit name;
          inherit hostname;
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
          ./hosts/hypoxic/configuration.nix # load configuration.nix
          {
            environment.systemPackages = [alejandra.defaultPackage.${system}]; #always use the opinionated alejandra formater
          }

          home-manager.nixosModules.home-manager
          {
            home-manager = {
              # useGlobalPkgs = true;
              useUserPackages = true;
              users.romy = import ./users/romy/home.nix;
              extraSpecialArgs = {
                # pass config variables from above
                inherit (inputs) hyprland-plugins;
                inherit (inputs) stylix;
                hostname = "hypoxic";
                inherit theme;
                inherit timezone;
                editor = "nvim";
                email = "";
                font = "Intel One Mono"; # Selected font
                fontPkg = pkgs.intel-one-mono; # Font package
                name = "romy";
                spawnEditor = "nvim";
                term = "alacritty"; # Default terminal command;
                username = "romy";
                wm = "gnome"; # Selected window manager or desktop environment
                wmType = "wayland"; # x11 or wayland
              };
            };
          }
        ];
        specialArgs = {
          # pass config variables from above
          inherit username;
          inherit name;
          hostname = "hypoxic";
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
