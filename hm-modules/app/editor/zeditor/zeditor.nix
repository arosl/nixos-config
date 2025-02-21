{
  pkgs,
  lib,
  conifg,
  ...
}: {
  programs.zed-editor = {
    enable = true;
    extensions = [
      "catppuccin"
      "elixir"
      "elm"
      "git-firefly"
      "log"
      "make"
      "nix"
      "powershell"
      "python"
      "rainbow-csv"
      "ssh-config"
      "toml"
      "xml"
    ];

    ## everything inside of these brackets are Zed options.
    userSettings = {
      assistant = {
        enabled = true;
        version = "2";
        default_open_ai_model = null;
        ### PROVIDER OPTIONS
        ### zed.dev models { claude-3-5-sonnet-latest } requires github connected
        ### anthropic models { claude-3-5-sonnet-latest claude-3-haiku-latest claude-3-opus-latest  } requires API_KEY
        ## copilot_chat models { gpt-4o gpt-4 gpt-3.5-turbo o1-preview } requires github connected
        default_model = {
          provider = "copilot_chat";
          model = "gpt-4o";
        };

        inline_alternatives = [
          {
            provider = "copilot_chat";
            model = "o1-mini";
          }
        ];
      };

      node = {
        path = lib.getExe pkgs.nodejs;
        npm_path = lib.getExe' pkgs.nodejs "npm";
      };

      hour_format = "hour24";
      auto_update = false;
      terminal = {
        alternate_scroll = "off";
        blinking = "off";
        copy_on_select = false;
        dock = "bottom";
        detect_venv = {
          on = {
            directories = [".env" "env" ".venv" "venv"];
            activate_script = "default";
          };
        };
        env = {
          TERM = "alacritty";
        };
        font_family = "FiraCode Nerd Font";
        font_features = null;
        font_size = null;
        line_height = "comfortable";
        option_as_meta = false;
        button = false;
        shell = "system";
        toolbar = {
          title = true;
        };
        working_directory = "current_project_directory";
      };

      lsp = {
        rust-analyzer = {
          binary = {
            path_lookup = pkgs.rust-analyzer;
          };
        };
        nixd = {
          settings = {
            diagnostic = {
              suppress = [
                # "sema-extra-with"
                "sema-unused-def-lambda-noarg-formal"
              ];
            };
          };
        };
        elixir-ls = {
          binary = {
            path_lookup = pkgs.elixir-ls;
          };
          settings = {
            dialyzerEnabled = true;
          };
        };
        elm = {
          binary = {
            path_lookup = pkgs.elmPackages.elm;
          };
        };
        pyright = {
          binary = {
            path_lookup = pkgs.pyright;
          };
        };
        gopls = {
          binary = {
            path_lookup = pkgs.gopls;
          };
        };
        bash-language-server = {
          binary = {
            path_lookup = pkgs.nodePackages_latest.bash-language-server;
          };
        };
      };

      languages = {
        Elixir = {
          language_servers = ["!lexical" "elixir-ls" "!next-ls"];
          format_on_save = {
            external = {
              command = "mix";
              arguments = ["format" "--stdin-filename" "{buffer_path}" "-"];
            };
          };
        };
        Elm = {
          language_servers = ["elm-language-server"];
          format_on_save = {
            external = {
              command = "elm-format";
              arguments = ["--stdin" "--elm-version=0.19"];
            };
          };
        };
        HEEX = {
          language_servers = ["!lexical" "elixir-ls" "!next-ls"];
          format_on_save = {
            external = {
              command = "mix";
              arguments = ["format" "--stdin-filename" "{buffer_path}" "-"];
            };
          };
        };
        Nix = {
          language_servers = ["nixd" "!nil"];
          format_on_save = {
            external = {
              command = "alejandra";
              arguments = ["--quiet" "--"];
            };
          };
        };
        Python = {
          language_servers = ["pyright"];
          format_on_save = {
            external = {
              command = "black";
              arguments = ["-"];
            };
          };
        };
        Golang = {
          language_servers = ["gopls"];
          format_on_save = {
            external = {
              command = "gofmt";
              arguments = ["-w" "{buffer_path}"];
            };
          };
        };
        Rust = {
          language_servers = ["rust-analyzer"];
          format_on_save = {
            external = {
              command = "rustfmt";
              arguments = ["--emit=stdout"];
            };
          };
        };
      };

      vim_mode = true;
      ## tell zed to use direnv and direnv can use a flake.nix enviroment.
      load_direnv = "shell_hook";
      base_keymap = "VSCode";
      show_whitespaces = "all";
      ui_font_size = 16;
      buffer_font_size = 16;
    };
  };
}
