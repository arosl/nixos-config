{
  config,
  lib,
  pkgs,
  ...
}: let
  myCbxScript = ''
    #!/bin/sh

    # Ensure the script is called with at least two arguments
    if [ "$#" -ne 2 ]; then
      echo "Usage: $0 <copy|cut> <file_path>"
      exit 1
    fi

    ACTION=$1
    FILE=$2

    # Check if the file exists
    if [ ! -f "$FILE" ]; then
      echo "Error: File '$FILE' not found."
      exit 1
    fi

    # Ensure the action is either "copy" or "cut"
    if [ "$ACTION" != "copy" ] && [ "$ACTION" != "cut" ]; then
      echo "Error: Invalid action. Use 'copy' or 'cut'."
      exit 1
    fi

    # Get the MIME type of the file
    MIME_TYPE=$(file -b --mime-type "$FILE")

    # Detect Wayland or X11 environment
    if [ "$XDG_SESSION_TYPE" = "wayland" ]; then
      # Use wl-copy for Wayland
      wl-copy --type="$MIME_TYPE" < "$FILE"
      echo "File '$FILE' copied to clipboard (Wayland)."
    elif [ "$XDG_SESSION_TYPE" = "x11" ]; then
      # Use xclip for X11
      xclip -selection clipboard -t "$MIME_TYPE" -i "$FILE"
      echo "File '$FILE' copied to clipboard (X11)."
    else
      echo "Error: Unsupported session type. Only Wayland and X11 are supported."
      exit 1
    fi
  '';
in {
  imports = [
    ../../pkgs/ranger.nix
    ../terminal/kitty.nix
  ];

  home.packages = with pkgs; [
    ranger
    ripdrag
    highlight
    (pkgs.writeScriptBin "cbx" myCbxScript)
  ];
  xdg.mimeApps.associations.added = {
    "inode/directory" = "ranger.desktop";
  };
  home.file.".config/ranger/rc.conf".source = ./rc.conf;
  home.file.".config/ranger/rifle.conf".source = ./rifle.conf;
  home.file.".config/ranger/scope.sh" = {
    source = ./scope.sh;
    executable = true;
  };
  home.file.".config/ranger/commands.py" = {
    source = ./commands.py;
    executable = true;
  };
  home.file.".config/ranger/commands_full.py" = {
    source = ./commands_full.py;
    executable = true;
  };
  home.file.".config/ranger/colorschemes/hail.py" = {
    source = ./colorschemes/hail.py;
    executable = true;
  };
}
