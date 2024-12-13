{
  pkgs,
  config,
  theme,
  ...
}: {
  programs.helix = {
    enable = true;

    settings = {
      theme = "catppuccin_mocha";
      editor = {
        line-number = "relative";
      };
    };

    languages = {
      language-server = {
        nixd = {
          command = "nixd";
        };
        pyright = {
          command = "pyright";
          args = ["--stdio"];
          config = {
            settings = {
              python = {
                analysis = {
                  autoImportCompletions = true;
                  typeCheckingMode = "off";
                  autoSearchPaths = true;
                  useLibraryCodeForTypes = true;
                  diagnosticMode = "workspace";
                };
              };
            };
          };
        };
      };

      language = [
        {
          name = "nix";
          formatter = {
            command = "alejandra";
            args = ["-qq"];
          };
          auto-format = true;
          language-servers = ["nixd"];
        }
        {
          name = "python";
          formatter = {
            command = "black";
            args = ["-" "-q"];
          };
          auto-format = true;
          language-servers = ["pyright"];
        }
      ];
    };
  };
}
