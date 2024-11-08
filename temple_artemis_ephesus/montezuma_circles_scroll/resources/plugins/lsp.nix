{...}:
{
  #lsp improvements and prettification
  lspsaga.enable = true;

  lsp-format.enable = false; #disabled while testing conform-nvim

  conform-nvim = {
    enable = true;
    formattersByFt = {
      clojure = ["cljstyle"];
      haskell = ["ormolu"];
      javascript = ["prettierd"];
      javascriptreact = ["prettierd"];
      typescript = ["prettierd"];
      typescriptreact = ["prettierd"];
      python = ["black"];
      lua = ["stylua"];
      markdown = ["prettierd"];
      nix = ["alejandra"];
      html = ["rustywind" "stylelint" "htmlbeautifier"];
      css = ["stylelint"];
      bash = ["beautysh"];
      cabal = ["cabal_fmt"];
      json = ["fixjson"];
      yaml = ["yamlfmt"];
    };
  };
  none-ls = {
    enable = false;
    enableLspFormat = false; #disabled while testing conform-nvim
    sources = {
      formatting = {
        alejandra.enable = true;
        black.enable = true;
        clang_format.enable = true;
        shellharden.enable = true;
        yamlfmt.enable = true;
        isort.enable = true;
        terraform_fmt.enable = true;
      };

      diagnostics = {
        mypy.enable = true;
        pylint.enable = true;
        cppcheck.enable = true;
        zsh.enable = true;
      };
    };
  };

  #adds pictograms to lsp
  lspkind.enable = true;

  #lsp servers and keymaps related to them
  lsp = {
    enable = true;

    keymaps = {
      diagnostic = {
        "<leader>cd" = {
          action = "open_float";
          desc = "Line Diagnostics";
        };
        "<leader>j" = {
          action = "goto_next";
          desc = "Next Diagnostic";
        };
        "<leader>k" = {
          action = "goto_prev";
          desc = "Previous Diagnostic";
        };
      };
    };

    servers = {
      tailwindcss.enable = true;
      cssls.enable = true;
      html.enable = true;

      phpactor.enable = true;
      tsserver.enable = true;
      eslint.enable = true;

      dagger.enable = true;
      dockerls.enable = true;
      jsonls.enable = true;
      bashls.enable = true;


      clangd.enable = true;

      clojure-lsp.enable = true;

      pylsp = {
        enable = true;
        settings = {
          plugins = {
            flake8.enabled = true;
            ruff.enabled = true;
          };
        };
      };
      terraformls.enable = true;
      nixd.enable = true;

      yamlls.enable = true;

      gopls.enable = true;

      helm-ls.enable = true;
      hls = {
        enable = true;
      };
      java-language-server.enable = true;

      lua-ls = {
        enable = true;
        settings.telemetry.enable = false;
      };
    };
  };
}
