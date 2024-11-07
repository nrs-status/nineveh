[
  #recursive unfold in current foldable
  {
    action = "zczA";
    key = "zO";
    mode = ["n"];
  }
  #fine-grained undo
  {
    action = "<c-g>u,";
    key = ",";
    mode = ["i"];
  }
  {
    action = "<c-g>u;";
    key = ";";
    mode = ["i"];
  }
  {
    action = "<c-g>u<bs>";
    key = "<bs>";
    mode = ["i"];
  }
  {
    action = "<c-g>u<cr>";
    key = "<cr>";
    mode = ["i"];
  }
  {
    action = "<c-g>u<spc>";
    key = "<spc>";
    mode = ["i"];
  }
  {
    action = ":noh<CR><Esc>"; #unselect search match
    key = "<Esc>";
  }
  {
    action = ":q<cr>";
    key = "<Leader>qq";
  }
  {
    action = "<Esc>ja";
    key = "jj";
    mode = ["i"];
  }
  {
    action = "<Esc>ka";
    key = "kk";
    mode = ["i"];
  }
  {
    action = "<Esc>]]";
    key = "<leader>]]";
  }
  {
    action = "<Esc>]}";
    key = "<leader>]}";
    mode = ["i"];
  }
  {
    action = "<Esc> ])";
    key = "<leader>])";
  }
  {
    action = "<Esc>:q<cr>";
    key = "<leader>qq";
    mode = ["i"];
  }
  {
    action = ":wq<cr>";
    key = "<Leader>wq";
  }
  {
    action = ":q!<cr>";
    key = "<leader>q!";
  }
  {
    action = ":w<cr>";
    key = "<leader>ww";
  }
  {
    action = ":Telescope live_grep<cr>";
    key = "<leader>lg";
  }
  {
    action = "<Esc>l";
    key = "jk";
    mode = ["i"];
  }
  {
    action = "<Esc>";
    key = "kj";
    mode = ["i"];
  }
  {
    action = "<Cmd>Neotree toggle<CR>";
    key = "<leader>n";
  }
  {
    action = "<Cmd>lua vim.lsp.buf.hover()<cr>";
    key = "<leader>gk";
    mode = ["n"];
    options.remap = true;
  }
  {
    action = "<Cmd>lua vim.lsp.buf.definition()<cr>";
    key = "<leader>gd";
    mode = ["n"];
  }
  #currently not working, at least with ts and python
  {
    action = "<Cmd>vim.lsp.buf.type_definition()<cr>";
    key = "<leader>gy";
    mode = ["n"];
  }
  #currently not working, at least with ts and python

  {
    action = "<cmd>vim.lsp.buf.implementation()<cr>";
    key = "<leader>gi";
    mode = ["n"];
  }
  #currently not working, at least with ts and python

  {
    action = "<cmd>vim.lsp.buf.code_action()<cr>";
    key = "<leader>ca";
    mode = ["n"];
  }
  {
    action = "$";
    key = "<leader>ll";
    mode = ["n" "i"];
  }
  {
    action = "0";
    key = "<leader>hh";
    mode = ["n" "i"];
  }
  {
    key = "f"; #used to activate the hop plugin
    action.__raw = ''
      function()
        require'hop'.hint_char1({
          direction = require'hop.hint'.HintDirection.AFTER_CURSOR,
          current_line_only = false
        })
      end
    '';
    options.remap = true;
  }
  {
    key = "<C-f>";
    action.__raw = ''
      function ()
        return "/" .. vim.fn.getcharstr() .. "<cr><cmd>nohl<cr>"
      end
    '';
    options.expr = true; #makes it such that what is evaluated is the return value of the entire expression
    mode = ["i" "n" "v"];
  }
  {
    key = "F";
    action.__raw = ''
      function()
        require'hop'.hint_char1({
          direction = require'hop.hint'.HintDirection.BEFORE_CURSOR,
          current_line_only = false
        })
      end
    '';
    options.remap = true;
  }
]
