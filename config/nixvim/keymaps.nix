{
    keymaps =
        let
            setmap = mode: key: action: options: {
                inherit mode key action options;
            };

            # Command wrapper (e.g., cmd "write" -> "<cmd>write<CR>")
            cmd = str: "<cmd>${str}<CR>";

            nmap = key: action: desc: setmap "n" key action { inherit desc; };

            # 4. Idris specific helper
            # Usage: idrisMap "cs" "case_split" "description"
            # Result: Maps `<leader>ics` to `idris2.code_action.case_split()`
            idrisMap = key: func: desc:
                nmap "<leader>i${key}"
                     (cmd "lua require('idris2.code_action').${func}()")
                     "Idris: ${desc}";
        in
        [
            # --- General ---
            (nmap "<leader>qw" (cmd "wq")    "save and quit")
            (nmap "<C-s>"      (cmd "write") "save")
            (nmap "<leader>w"  (cmd "write") "save")
            (nmap "<leader>cd" (cmd "Cd")    "cd to this file dir")

            # Exception: custom options need the raw 'setmap'
            (setmap "n" "<Esc>" (cmd "nohl") {
                desc   = "No Highlight";
                silent = true;
            })

            # --- Make ---
            (nmap "<leader>mr"  (cmd "make run")         "(m)ake (r)un")
            (nmap "<leader>mb"  (cmd "make build")       "(m)ake (b)uild")
            (nmap "<leader>mqb" (cmd "make build<CR>a")  "quick build")

            # --- Editing ---
            (nmap "<leader>rw" ''%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>'' "(r)eplace (w)ord")

            # --- Mini Modules ---
            (nmap "-"           (cmd "lua MiniFiles.open()") "Open parent dir")
            (nmap "<leader>pb"  (cmd "Pick buffers")         "(p)ick (b)uffers")
            (nmap "<leader>pf"  (cmd "Pick files")           "(p)ick (f)iles")
            (nmap "<leader>ph"  (cmd "Pick help")            "(p)ick (h)elp")
            (nmap "<leader>:"   (cmd "Pick commands")        "(p)ick (c)ommand")
            (nmap "<leader>po"  (cmd "Pick options")         "(p)ick (o)ption")

            # --- Git ---
            (nmap "<leader>gn" (cmd "Neogit") "open NeoGit")

            # --- Terminals ---
            (setmap "t" "<C-q>" "<C-\\><C-n>" {
                desc   = "quit terminal";
                nowait = true;
            })
            (nmap "<leader>ot" (cmd "term<CR>a")       "(o)pen (t)erminal")
            (nmap "<leader>vt" (cmd "vs | term<CR>a")  "(v)ertical pane (t)erminal")
            (nmap "<leader>st" (cmd "sp | term<CR>a")  "horizontal pane (t)erminal")

            # --- Quickfix / Lists ---
            (nmap "<C-k>"      (cmd "cnext") "Next quickfix")
            (nmap "<C-j>"      (cmd "cprev") "Previous quickfix")
            (nmap "<leader>k"  (cmd "lnext") "Next location")
            (nmap "<leader>j"  (cmd "lprev") "Previous location")

            # Mode specific exceptions
            (setmap "i" "<C-k>" "<C-k>" { desc = "Input Digraph"; })

            # --- Visual/Motion ---
            (setmap ["n" "v"] "J" "mzJ`z"         { desc = "shift+j but cursor stays"; })
            (setmap ["n" "v"] "<leader>d" ''"_d'' { desc = "delete no register"; })
            (setmap ["i" "v"] "kj" "<Esc>"        { desc = "exit to normal"; })

            # --- IDRIS 2 KEYMAPS ---
            # REPL (The only one not using code_action)
            (nmap "<leader>iev"
                (cmd "lua require('idris2.repl').evaluate()")
                "Idris: evaluate")

            # Code Actions (Using the helper)
            (idrisMap "cs" "case_split"   "case split")
            (idrisMap "mc" "make_case"    "make case")
            (idrisMap "ml" "make_lemma"   "make lemma")
            (idrisMap "ac" "add_clause"   "add clause")
            (idrisMap "es" "expr_search"  "search expression")
            (idrisMap "gd" "generate_def" "generate definition")
            (idrisMap "rh" "refine_hole"  "refine hole")
            (idrisMap "in" "intro"        "intro")
            (nmap "<leader>imr" (cmd ''make % -o run | !./build/exec/run'') "make run for idris2")
            (nmap "<leader>imb" (cmd ''make % -o %:h'')                     "make build for idris2")
        ];
}
