{
  config,
  pkgs,
  ...
}: let
  # My shell aliases
  myAliases = {
    cat = "bat --plain";
    htop = "btm";
    fd = "fd -Lu";
    w3m = "w3m -no-cookie -v";
    man = "batman";
    nixos-rebuild = "systemd-run --no-ask-password --uid=0 --system --scope -p MemoryLimit=16000M -p CPUQuota=60% nixos-rebuild";
    open = "xdg-open";
    zed = "zeditor";
  };
in {
  programs = {
    eza = {
      enable = true;
      icons = "auto";
      #set programs.eza.enableNushellIntegration to false so it does not overwrite nu ls
      enableNushellIntegration = false;
    };

    nushell = {
      enable = true;
    };
    carapace = {
      enable = true;
      enableNushellIntegration = true;
      enableZshIntegration = true;
    };

    starship = {
      enable = true;
      settings = {
        add_newline = false;
        character = {
          success_symbol = "[➜](bold green)";
          error_symbol = "[➜](bold red)";
        };
      };
    };

    zsh = {
      enable = true;
      autosuggestion.enable = true;
      enableCompletion = true;
      syntaxHighlighting.enable = true;
      shellAliases = myAliases;
      initExtra = ''
        function puppetdeploy() {
          ssh -t "$1" 'sudo /local/sbin/deploy.sh'
        }
        _puppetdeploy() {
          local -a hosts
          # Collect hostnames from known_hosts
          hosts=($(awk '{print $1}' ~/.ssh/known_hosts | sed 's/,.*//' | uniq))
          # Offer these hosts as completions
          _describe 'hostname' hosts
        }
        compdef _puppetdeploy puppetdeploy
      '';
      oh-my-zsh = {
        enable = true;
        theme = "agnoster";
      };
    };

    yazi = {
      enable = true;
      enableNushellIntegration = true;
    };

    bash = {
      enable = true;
      enableCompletion = true;
      shellAliases = myAliases;
    };
    direnv = {
      enable = true;
      enableZshIntegration = true;
      enableNushellIntegration = true;
      nix-direnv.enable = true;
    };

    fzf = {
      enable = true;
      enableZshIntegration = true;
    };

    mcfly = {
      enable = true;
      fzf.enable = true;
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
    nix-direnv
  ];
}
