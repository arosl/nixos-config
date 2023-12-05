{
  config,
  pkgs,
  ...
}: let
  # My shell aliases
  myAliases = {
    ll = "eza --icons -l -T -L=1";
    ls = "eza --icons";
    cat = "bat --plain";
    htop = "btm";
    fd = "fd -Lu";
    w3m = "w3m -no-cookie -v";
    man = "batman";
    nixos-rebuild = "systemd-run --no-ask-password --uid=0 --system --scope -p MemoryLimit=16000M -p CPUQuota=60% nixos-rebuild";
    home-manager = "systemd-run --no-ask-password --uid=1000 --user --scope -p MemoryLimit=16000M -p CPUQuota=60% home-manager";
  };
in {
  programs = {
    zsh = {
      enable = true;
      enableAutosuggestions = true;
      enableCompletion = true;
      syntaxHighlighting.enable = true;
      shellAliases = myAliases;
      oh-my-zsh = {
        enable = true;
        theme = "agnoster";
      };
    };

    bash = {
      enable = true;
      enableCompletion = true;
      shellAliases = myAliases;
    };
    direnv = {
      enable = true;
      enableZshIntegration = true;
      nix-direnv.enable = true;
    };
  };

  home.packages = with pkgs; [
    bat
    bat-extras.batman
    bottom
    cowsay
    direnv
    eza
    fd
    gnugrep
    gnused
    lolcat
    neofetch
    nix-direnv
  ];
}
