{
  keymaps =
    let
      setmap = mode: key: action: options: {
        mode = mode;
        key = key;
        action = action;
        options = options;
      };
    in
    [
      (setmap "n" "<leader>qw" "<cmd>wq<CR>" { desc = "save and quit"; })
      (setmap "n" "<Esc>" "<cmd>nohl<CR>" {
        desc = "No Highlight";
        silent = true;
      })
      (setmap "n" "<C-s>" "<cmd>write<CR>" { desc = "save"; })
      (setmap "n" "<leader>w" "<cmd>write<CR>" { desc = "save"; })
      (setmap "n" "<leader>cd" "<cmd>Cd<CR>" { desc = "cd to this file dir"; })

      # Make
      (setmap "n" "<leader>mr" "<cmd>term make run<CR>" { desc = "(m)ake (r)un"; })
      (setmap "n" "<leader>mb" "<cmd>term make build<CR>" { desc = "(m)ake (b)uild"; })
      (setmap "n" "<leader>mqb" "<cmd>term make build<CR>a<CR>" { desc = "quick build"; })

      (setmap "n" "<leader>rw" ''%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>'' {
        desc = "(r)eplace (w)ord";
      })

      # Open MiniFiles
      (setmap "n" "-" "<cmd>lua MiniFiles.open()<CR>" { desc = "Open parent dir"; })

      # MiniPick
      (setmap "n" "<leader>pb" "<cmd>Pick buffers<CR>" { desc = "(p)ick (b)uffers"; })
      (setmap "n" "<leader>pf" "<cmd>Pick files<CR>" { desc = "(p)ick (f)iles"; })
      (setmap "n" "<leader>ph" "<cmd>Pick help<CR>" { desc = "(p)ick (h)elp"; })
      (setmap "n" "<leader>:" "<cmd>Pick commands<CR>" { desc = "(p)ick (c)ommand"; })
      (setmap "n" "<leader>po" "<cmd>Pick options<CR>" { desc = "(p)ick (o)ption"; })

      # NeoGit
      (setmap "n" "<leader>gn" "<cmd>Neogit<CR>" { desc = "open NeoGit"; })

      # Terminals
      (setmap "t" "<C-q>" "<C-\><C-n>" {
        desc = "quit terminal";
        nowait = true;
      })
      (setmap "n" "<leader>ot" "<cmd>term<CR>a" { desc = "(o)pen (t)erminal"; })
      (setmap "n" "<leader>vt" "<cmd>vs | term<CR>a" { desc = "(v)ertical pane (t)erminal"; })
      (setmap "n" "<leader>st" "<cmd>sp | term<CR>a" { desc = "horizontal pane (t)erminal"; })

      # using fixlist
      (setmap "n" "<C-k>" "<cmd>cnext<CR>" { desc = "Next quickfix"; })
      (setmap "n" "<C-j>" "<cmd>cprev<CR>" { desc = "Previous quickfix"; })
      (setmap "n" "<leader>k" "<cmd>lnext<CR>" { desc = "Next location"; })
      (setmap "n" "<leader>j" "<cmd>lprev<CR>" { desc = "Previous location"; })

      (setmap [ "n" "v" ] "J" "mzJ`z" {
        desc = "shift+j but the cursor stay in place";
      })
      (setmap [ "n" "v" ] "<leader>d" ''"_d'' {
        desc = "delete without saving to register";
      })

      (setmap [ "i" "v" ] "kj" "<Esc>" { desc = "exit to normal"; })
    ];
}
