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
  } @ inputs: let #this all need to be rearanged so i can have muliple user and systems
    # ---- SYSTEM SETTINGS ---- #
    hostname = "phantom"; # hostname
    locale = "en_US.UTF-8"; # select locale
    profile = "personal"; # select a profile defined from my profiles directory
    sshkey_public = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIK9WYZgphn4uQ5ZqBkTwbSIk2htGe74EiANdItjgWlrM andreas@ros.land"; # Public sshkey
    system = "x86_64-linux"; # system arch
    timezone = "America/Cancun"; # select timezone

    # ----- USER SETTINGS ----- #
    browser = "qutebrowser"; # Default browser; must select one from ./user/app/browser/
    dotfilesDir = "~/Personal/nixos2.0"; # absolute path of the local repo
    editor = "nvim"; # Default editor;
    email = "andreas@ros.land"; # email (used for certain configurations)
    font = "Intel One Mono"; # Selected font
    fontPkg = pkgs.intel-one-mono; # Font package
    name = "Andreas"; # name/identifier
    spawnEditor = "nvim";
    term = "alacritty"; # Default terminal command;
    theme = "catppuccin-mocha";
    username = "andreas"; # username
    wm = "hyprland"; # Selected window manager or desktop environment; must select one in both ./user/wm/ and ./system/wm/
    wmType = "wayland"; # x11 or wayland

    # create patched nixpkgs
    nixpkgs-patched = (import nixpkgs {inherit system;}).applyPatches {
      name = "nixpkgs-patched";
      src = nixpkgs;
    };

    # configure pkgs
    pkgs = import nixpkgs-patched {
      inherit system;
      config = {allowUnfree = true;};
    };

    # configure lib
    lib = nixpkgs.lib;
  in {
    homeConfigurations = {
      andreas = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [./users/andreas/home.nix]; # load home.nix from selected PROFILE
        extraSpecialArgs = {
          # pass config variables from above
          inherit username;
          inherit name;
          inherit hostname;
          inherit profile;
          inherit email;
          inherit dotfilesDir;
          inherit theme;
          inherit font;
          inherit fontPkg;
          inherit wm;
          inherit wmType;
          inherit browser;
          inherit editor;
          inherit term;
          inherit timezone;
          inherit spawnEditor;
          inherit (inputs) stylix;
          inherit (inputs) hyprland-plugins;
        };
      };
    };
    nixosConfigurations = {
      phantom = lib.nixosSystem {
        inherit system;
        modules = [
          ./hosts/phantom/configuration.nix # load configuration.nix from selected PROFILE
          {
            environment.systemPackages = [alejandra.defaultPackage.${system}]; #always use the opinionated alejandra formater
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
