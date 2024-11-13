{...}:
{
  cmp = {
    enable = true;
    autoEnableSources = true;
    settings = {
      mapping = {
        __raw = ''
          cmp.mapping.preset.insert({
          ['<C-j>'] = cmp.mapping.select_next_item(),
          ['<C-k>'] = cmp.mapping.select_prev_item(),
          ['<C-c>'] = cmp.mapping.abort(),

          ['<C-b>'] = cmp.mapping.scroll_docs(-4),

           ['<C-w>'] = cmp.mapping.scroll_docs(4),


           ['<C-Space>'] = cmp.mapping.complete(), --invokes completion


           ['<C-CR>'] = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true }),
          })
        '';
      };
      sources = [
        # {
        #   name = "nvim_lsp";
        # }
        # {
        #   name = "luasnip";
        # }
        {
          name = "path";
        }
        # {
        #   name = "nvim_lua";
        # }
        # {
        #   name = "treesitter";
        # }
        # {
        #   name = "zsh";
        # }
        #{ --will cause errors if enabled, use the one enabled in simplePlugins.nix
        #  name = "cmdline";
        #}
        # {
        #   name = "kitty";
        # }
        # {
        #   name = "ctags";
        # }
        # {
        #   name = "sql";
        # }
      ];
    };
  };

  cmp-nvim-lsp.enable = true;
  cmp-nvim-lua.enable = true;
  cmp-rg.enable = true;
  cmp-treesitter.enable = true;
  cmp-zsh.enable = true;
  cmp-path.enable = true;
  cmp_luasnip.enable = true;
}
