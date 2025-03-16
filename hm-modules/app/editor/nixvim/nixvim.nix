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

      # Behaviour
      #mapleader = " ";  # Space as leader key
      hidden = true;
      errorbells = false;
      swapfile = false;
      backup = false;
      undodir = "$HOME/.vim/undodir"; # Expanded at runtime
      undofile = true;
      backspace = "indent,eol,start";
      splitright = true;
      splitbelow = true;
      autochdir = false;
      modifiable = true;
      encoding = "UTF-8";
      showmode = false;
    };

    autoCmd = [
      {
        event = [ "FileType" ];
        pattern = [ "puppet" ];
        command = "TSBufEnable highlight";
      }
    ];

    plugins = {
      lualine.enable = true;
      telescope.enable = true;
      comment.enable = true;
      web-devicons.enable = true;
      indent-blankline.enable = true;
      nvim-tree.enable = true;
      which-key.enable = true;

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
            puppet = [pkgs.puppet-lint];
            python = ["black"];
          };
          formatOnSave = true;
        };
      };
    };

    # Install extra plugins
    extraPackages = with pkgs.vimPlugins; [
      vim-highlightedyank
    ];

    keymaps = [
      # Normal mode: Toggle comment on the current line
      {
        mode = "n";
        key = "<C-/>";
        action = "<Cmd>lua require('Comment.api').toggle.linewise.current()<CR>";
        options = {
          desc = "Toggle comment on current line";
          silent = true;
        };
      }
      # Visual mode: Toggle comment on selected lines
      {
        mode = "v";
        key = "<C-/>";
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
        action = "<Cmd>lua require('conform').format()<CR>";
        options = {
          desc = "Manually format the current file";
          noremap = true;
          silent = true;
        };
      }
    ];
  };
}
