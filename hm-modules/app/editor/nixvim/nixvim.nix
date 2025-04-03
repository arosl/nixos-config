{
  config,
  lib,
  pkgs,
  ...
}: {
  programs.nixvim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
    clipboard = {
      providers.wl-copy.enable = true;
    };

    colorschemes.catppuccin = {
      enable = true;
      autoLoad = true;
      settings = {
        flavour = "mocha"; # Can be: latte, frappe, macchiato, mocha
        integrations = {
          cmp = true;
          gitsigns = true;
          nvimtree = true;
          telescope = true;
          treesitter = true;
        };
      };
    };
    opts = {
      # Tab / Indentation
      tabstop = 2;
      shiftwidth = 2;
      softtabstop = 2;
      expandtab = true;
      smartindent = true;
      wrap = false;

      # Search
      incsearch = true;
      ignorecase = true;
      smartcase = true;
      hlsearch = false;

      # Appearance
      number = true;
      relativenumber = true;
      termguicolors = true;
      colorcolumn = "100";
      signcolumn = "yes";
      cmdheight = 1;
      scrolloff = 10;
      completeopt = "menuone,noinsert,noselect";
      showmatch = true;
      matchtime = 2;

      # Behaviour
      hidden = true;
      errorbells = false;
      swapfile = false;
      backup = false;
      undodir = "${config.home.homeDirectory}/.vim/undodir";

      undofile = true;
      backspace = "indent,eol,start";
      splitright = true;
      splitbelow = true;
      autochdir = false;
      modifiable = true;
      encoding = "UTF-8";
      showmode = false;
      clipboard = "unnamedplus";
    };

    autoCmd = [
      {
        event = ["FileType"];
        pattern = ["puppet"];
        command = "TSBufEnable highlight";
      }
    ];

    plugins = {
      noice.enable = true;
      lualine.enable = true;
      telescope.enable = true;
      comment.enable = true;
      web-devicons.enable = true;
      indent-blankline.enable = true;
      neo-tree.enable = true;
      lazygit.enable = true;
      nvim-surround.enable = true;
      harpoon.enable = true;

      which-key = {
        enable = true;

        settings = {
          delay = 200;
          spec = [];
        };
      };

      # Enable treesitter
      treesitter = {
        enable = true;
        settings = {
          indent.enable = true;
          ensureInstalled = ["puppet"];
        };
      };
      # Enable LSPs
      lsp.enable = true;
      lsp.servers = {
        nixd.enable = true;
        pyright.enable = true;
      };

      # Enable formatters
      conform-nvim = {
        enable = true;
        settings = {
          formattersByFt = {
            # nix = [pkgs.nixfmt-rfc-style];
            nix = ["alejandra"];
            puppet = ["puppet-lint"];
            python = ["black"];
          };
          formatOnSave = true;
        };
      };

      #configure vim obsidian
      obsidian = {
        enable = true;
        settings = {
          dir = "~/myobsvault";
        };
      };
    };

    # Install extra plugins
    extraPackages = with pkgs.vimPlugins; [
      vim-highlightedyank
    ];

    globals.mapleader = " ";
    keymaps = [
      # Normal mode: Toggle comment on the current line
      {
        mode = ["n" "i"];
        key = ":C-_";
        action = "<Cmd>lua require('Comment.api').toggle.linewise.current()<CR>";
        options = {
          desc = "Toggle comment on current line";
          silent = true;
        };
      }
      # Visual mode: Toggle comment on selected lines
      {
        mode = "v";
        key = "<C-_>";
        action = "<Cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>";
        options = {
          desc = "Toggle comment on selected lines";
          noremap = true;
          silent = true;
        };
      }
      {
        mode = "n";
        key = "<leader>f";
        action = "<CMD>lua require('conform').format()<CR>";
        options = {
          desc = "Manually format the current file";
          noremap = true;
          silent = true;
        };
      }
      {
        mode = "n";
        key = "<leader>n";
        action = "<CMD>Neotree toggle<CR>";
        options = {
          desc = "Toggle Neo-tree";
        };
      }
      {
        mode = "n";
        key = "<leader>gg";
        action = "<CMD>LazyGit<CR>";
        options = {
          desc = "Toggle LazyGit";
          noremap = true;
          silent = true;
        };
      }
      # Add surround (like ys)
      {
        mode = "n";
        key = "<leader>ys";
        action = ''
          <cmd>lua vim.api.nvim_feedkeys("ys", "m", false)<CR>'';
        options.desc = "Add surround (like ys)";
      }

      # Delete surround (like ds)
      {
        mode = "n";
        key = "<leader>ds";
        action = ''
          <cmd>lua vim.api.nvim_feedkeys("ds", "m", false)<CR>'';
        options.desc = "Delete surround (like ds)";
      }

      # Change surround (like cs)
      {
        mode = "n";
        key = "<leader>cs";
        action = ''
          <cmd>lua vim.api.nvim_feedkeys("cs", "m", false)<CR>'';
        options.desc = "Change surround (like cs)";
      }

      #harpoon keys
      {
        mode = "n";
        key = "<leader>a";
        action = "<CMD>lua require('harpoon.mark').add_file()<CR>";
        options.desc = "Harpoon: Add file";
      }
      {
        mode = "n";
        key = "<leader>m";
        action = "<CMD>lua require('harpoon.ui').toggle_quick_menu()<CR>";
        options.desc = "Harpoon: Toggle menu";
      }
      {
        mode = "n";
        key = "<leader>1";
        action = "<CMD>lua require('harpoon.ui').nav_file(1)<CR>";
        options.desc = "Harpoon: Go to file 1";
      }
      {
        mode = "n";
        key = "<leader>2";
        action = "<CMD>lua require('harpoon.ui').nav_file(2)<CR>";
        options.desc = "Harpoon: Go to file 2";
      }
      {
        mode = "n";
        key = "<leader>3";
        action = "<CMD>lua require('harpoon.ui').nav_file(3)<CR>";
        options.desc = "Harpoon: Go to file 3";
      }
      {
        mode = "n";
        key = "<leader>4";
        action = "<CMD>lua require('harpoon.ui').nav_file(4)<CR>";
        options.desc = "Harpoon: Go to file 4";
      }

      #Telescope
      {
        mode = "n";
        key = "<leader>ff";
        action = "<CMD>Telescope find_files<CR>";
        options.desc = "Find files";
      }
      {
        mode = "n";
        key = "<leader>fg";
        action = "<CMD>Telescope live_grep<CR>";
        options.desc = "Live grep";
      }
      {
        mode = "n";
        key = "<leader>fb";
        action = "<CMD>Telescope buffers<CR>";
        options.desc = "Find buffers";
      }
      {
        mode = "n";
        key = "<leader>fh";
        action = "<CMD>Telescope help_tags<CR>";
        options.desc = "Help tags";
      }
      {
        mode = "n";
        key = "<leader>fo";
        action = "<CMD>Telescope oldfiles<CR>";
        options.desc = "Recent files";
      }
      {
        mode = "n";
        key = "<leader>fe";
        action = "<CMD>Telescope file_browser<CR>";
        options.desc = "Telescope File Browser";
      }
    ];
  };
}
