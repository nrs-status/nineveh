{
  pkgs,
  nixvimFlakeInput,
  system,
  helpers,
  ...
}: 
nixvimFlakeInput.legacyPackages.${system}.makeNixvimWithModule {
    inherit pkgs;
    module = {
      globals = {
        mapleader = " ";
        maplocalleader = " ";
      };

      clipboard = {
        register = "unnamedplus";
        providers.wl-copy.enable = true;
      };
      colorschemes.gruvbox.enable = true;

      opts = {
        number = true; # Show line numbers
        relativenumber = true; # Show relative line numbers

        mouse = "a"; # Enable mouse control
        mousemodel = "extend"; # Mouse right-click extends the current selection

        shiftwidth = 4;
        tabstop = 4;

        swapfile = false; # Disable the swap file
        modeline = true; # Tags such as 'vim:ft=sh'
        modelines = 100; # Sets the type of modelines
        undofile = true; # Automatically save and restore undo history
        incsearch = true; # Incremental search: show match for partly typed search command
        inccommand = "split"; # Search and replace: preview changes in quickfix list
        ignorecase = true; # When the search query is lower-case, match both lower and upper-case
        #   patterns
        smartcase = true; # Override the 'ignorecase' option if the search pattern contains upper
        #   case characters
        scrolloff = 8; # Number of screen lines to show around the cursor
        cursorline = true; # Highlight the screen line of the cursor
        cursorcolumn = true; # Highlight the screen column of the cursor

        #the following are config'd according to nvim-ufo recommendations
        foldcolumn = "0";
        foldlevel = 99;
        foldlevelstart = 99;
        foldenable = true;
      };


      keymaps = import ./resources/keymaps.nix;

      plugins = import ./resources/plugins {lib = pkgs.lib; inherit pkgs; inherit helpers; };

      filetype = {
        extension = {
          pl = "prolog";
        };
      }; 

      extraPlugins = with pkgs.vimPlugins; [
        vim-sexp vim-sexp-mappings-for-regular-people nvim-surround
      ] ++ [(pkgs.vimUtils.buildVimPlugin {
    name = "nvim-agda";
    src = pkgs.fetchFromGitHub {
        owner = "ashinkarov";
        repo = "nvim-agda";
        rev = "9024909ac5cbac0a0b6f1f3f7f2b65c907c8fc12";
        hash = "sha256-C2JWoCF2eeZFZ3J+1//FJ7FPqRE9w4CcwyEVI8vwZPw=";
    };
})];

      # the following will bug out due to doubling { { in the resulting lua file. centralize all auto commands and refactor as needed in order to fix this. in the meantime the lean lsp will go in extraLuaConfig
      # autoCmd = [
      #   {
      #     event = "FileType";
      #     pattern = "lean";
      #     callback = {
      #       __raw = ''flokawoka
      #         function(event)
      #           vim.lsp.start({
      #             name = 'leanls',
      #             cmd = k{'elan', 'run', 'stable', 'lake', 'serve'},
      #             root_dir = vim.fs.root(event.buf, k{'lakefile.toml',}),
      #           })
      #         end,
      #       '';
      #     };
      #   }
      # ];

      extraConfigLua = ''
--        -- leanlsp setup. temporary until I have time to fix nixvim autocmd
--        vim.api.nvim_create_autocmd('FileType', {
--          pattern = 'lean',
--          callback = function(event)
--                 vim.lsp.start({
--                   name = 'leanls',
--                   cmd = {'elan', 'run', 'stable', 'lake', 'serve'},
--                   root_dir = vim.fs.root(event.buf, {'lakefile.toml',}),
--                 })
--               end,
--        })
                -- toggle abs/relative numbers
                vim.api.nvim_command('command! Abs :set relativenumber!')
                local set= function(name) -- defines a function called 'set' that will automatically configure packages such that set "package" is equivalent to require('package').setup()
                  local ok, p = pcall(require, name) -- assigns the return value of pcall(require, name) to ok, p
                  if ok then
                    p.setup()
                  end
                end

                require'nvim-surround'.setup({
                  aliases = {
                    ["c"] = "}",
                    ["p"] = ")",
                  },
                })

         local function feedkeys_int(keys)
           local feedable_keys = vim.api.nvim_replace_termcodes(keys, true, false, true)
           vim.api.nvim_feedkeys(feedable_keys, 'n', true)
         end

         local function check_and_insert_space() -- function for <Tab> key
            -- Get the current cursor position
            local row, col = unpack(vim.api.nvim_win_get_cursor(0))

            -- Get the current line
            local line = vim.api.nvim_get_current_line()

            -- Check if completion menu is currently open. If it is, call the completion behaviour

            local cmp = require'cmp'
            if cmp.visible() then
                feedkeys_int("<Cmd>lua require('cmp').confirm({select = true})<CR>")
                return
            end

            -- Check if there's whitespace before the cursor
            local char_before_cursor = line:sub(col, col)
            if char_before_cursor:match("%s") or col == 0 then
                feedkeys_int("<Tab>")
                return
            end
            local ls = require("luasnip")
            if ls.expand_or_jumpable() then
              feedkeys_int("<Plug>luasnip-expand-or-jump")
              return
            end

            feedkeys_int("<Esc>la")
        end
        vim.keymap.set('i', '<Tab>', check_and_insert_space, {remap = true})


        -- https://vi.stackexchange.com/questions/39596/neovim-augroup-and-autocommand-in-lua-relative-line-numbering
        --  https://stackoverflow.com/questions/37552913/vim-how-to-keep-folds-on-save
        local rememberFolds = vim.api.nvim_create_augroup("rememberFolds", {clear = true})
        vim.api.nvim_create_autocmd(
          { "BufWinLeave"},
          {
            group = rememberFolds,
            pattern = "*",
            command = "mkview"
          }
        )
        vim.api.nvim_create_autocmd(
          {"BufWinEnter"},
          {
            group = rememberFolds,
            pattern = "*",
            command = "silent! loadview"
          }
        )
      '';
    };
}
