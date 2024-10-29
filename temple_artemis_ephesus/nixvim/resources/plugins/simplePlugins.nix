{
  #find-next-character motion
  hop = {
    enable = true;
  };

  telescope = {
    enable = true;
    extensions.fzf-native.enable = true;
  };

  #colored brackets, parentheses, etc.
  rainbow-delimiters.enable = true;

  markdown-preview = {
    enable = true;
    settings = {
      auto_close = true;
      auto_start = true;
      browser = "firefox";
      echo_preview_url = true;
        page_title = "「\${name}」";
  port = "8080";
  preview_options = {
    disable_filename = true;
    disable_sync_scroll = true;
    sync_scroll_type = "middle";
  };
      theme = "dark";
    };
  };

  #automatic nix indentation, filetype detection for .nix files, syntax highlighting for nix
  nix.enable = true;

  #automatically set expandtab (enables spaces instead of tabs) and shiftwidth (amount of whitespace to add or remove when an indentation command is called) automatically
  sleuth.enable = true;

  #commands to add/remove/replace brackets, parenthesis, etc. in combination with motion commands
  surround.enable = false;

  auto-save.enable = true;

  #automatically close brackets, parentheses, etc.
  nvim-autopairs = {
    enable = true;
    settings = {
      map_cr = true; #behaviour of <cr> when cursor is in the following position: {|}
    };
  };
  #pre-existing snippets collection
  friendly-snippets.enable = true;

  #snippets engine
  luasnip = {
    enable = true;
    fromLua = [
      {paths = ./snippets;}
    ];
    fromSnipmate = [
      {}
      {paths = ./snippets;}
    ];
  };

  # git integrations
  gitsigns.enable = true;

  #interactive repl
  conjure.enable = true;

  #add indentation guides
  indent-blankline = {
    enable = true;
    settings = {
      exclude = {
        buftypes = ["terminal" "nofile"];
        filetypes = ["help"];
      };
    };
  };

  #lean4 lang
  lean = {
    enable = true;
    leanPackage = null;
    abbreviations = {
      enable = true;
      extra = {
        osemic = "⦂"; 

      };
    };
    mappings = true;
  };


  #status line
  lualine.enable = true;

  #magit-like git interface
  neogit.enable = true;

  #debug adapter protocol client
  dap = {
    enable = true;
    extensions = {
      dap-python.enable = true;
    };
  };

  treesitter = {
    enable = true;
    indent = true;
  };

  #add context at the top of the window, wherever you are
  treesitter-context = {
    enable = false;
    settings = {
      max_lines = 5;
    };
  };

  #folding
  nvim-ufo = {
    enable = true;
    openFoldHlTimeout = 0;
    providerSelector = ''
      function()
        return { "lsp", "indent" }
      end
    '';
  };

  #automatically close html tags and rename them using treesitter
  ts-autotag = {
    enable = true;
  };

  nvim-colorizer = {
    enable = true;
    userDefaultOptions = {
      css = true;
      tailwind = true;
    };
  };

  ccc = {
    enable = true;
    settings = {
      highligher = {
        auto_enable = false;
      };
    };
  };
}
