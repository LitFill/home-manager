{
    pkgs,
    ...
}:
{
    programs.nixvim = {lib, ...}:
    {
        enable        = true;
        defaultEditor = true;
        viAlias       = true;
        vimAlias      = true;

        globals = {
            mapleader      = " ";
            maplocalleader = " ";

            neovide_opacity        = 0.75;
            neovide_normal_opacity = 0.80;
            guifont                = "JetBrainsMono NF:h14";

            GetShortPath = lib.nixvim.utils.mkRaw ''function()
                local buf_path = vim.api.nvim_buf_get_name(0)
                if buf_path == "" then
                    return "" -- Jika buffer kosong, tidak tampilkan apa-apa
                end

                local home = vim.fn.expand "$HOME"
                local project_home = home .. "/proyek"

                if buf_path:find("^" .. vim.pesc(project_home)) then
                    buf_path = buf_path:gsub("^" .. vim.pesc(project_home) .. "/", "")
                elseif buf_path:find("^" .. vim.pesc(home)) then
                    buf_path = buf_path:gsub("^" .. vim.pesc(home) .. "/", "")
                end

                local display_path1 = buf_path:gsub("//", "/")
                local display_path = display_path1:gsub("/", " -> ")

                return "%#MiniIconsPurple#  LitFill :: " .. display_path
            end'';
        };

        diagnostic.settings = {
            virtual_lines = {
                current_line = true;
            };
        };

        opts = {
            breakindent   = true;
            clipboard     = "unnamedplus";
            colorcolumn   = "80,120,200";
            cursorline    = true;
            expandtab     = true;
            ignorecase    = true;
            mouse         = "a";
            shiftwidth    = 4;
            signcolumn    = "yes:2";
            smartcase     = true;
            smartindent   = true;
            splitbelow    = true;
            splitright    = true;
            tabstop       = 4;
            termguicolors = true;
            undofile      = true;
            winborder     = "rounded";
            wrap          = false;
        };

        colorschemes.bamboo.enable = true;

        lsp = {
            inlayHints.enable = true;
            servers.lua_ls.config = {
                on_init = lib.nixvim.utils.mkRaw ''function(client)
                    if client.workspace_folders then
                        local path = client.workspace_folders[1].name
                        if
                            path ~= vim.fn.stdpath('config')
                            and (vim.uv.fs_stat(path .. '/.luarc.json') or vim.uv.fs_stat(path .. '/.luarc.jsonc'))
                        then return
                        end
                    end

                    client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
                        runtime = {
                            -- Tell the language server which version of Lua you're using (most
                            -- likely LuaJIT in the case of Neovim)
                            version = 'LuaJIT',
                            -- Tell the language server how to find Lua modules same way as Neovim
                            -- (see `:h lua-module-load`)
                            path = {
                                'lua/?.lua',
                                'lua/?/init.lua',
                            },
                        },
                        -- Make the server aware of Neovim runtime files
                        workspace = {
                            checkThirdParty = false,
                            library = {
                                vim.env.VIMRUNTIME
                            }
                        }
                    })
                end'';

                settings = {
                    Lua = {};
                };
            };
        };

        plugins = {
            mini-files = {
                enable = true;
                settings = {
                    windows = {
                        preview = true;
                        width_preview = 60;
                    };
                    options = {
                            use_as_default_explorer = true;
                        };
                };
            };

            mini-ai.enable          = true;
            mini-align.enable       = true;
            mini-bracketed.enable   = true;
            mini-comment.enable     = true;
            # mini-completion.enable  = true;
            mini-cursorword.enable  = true;
            mini-diff.enable        = true;
            mini-doc.enable         = true;
            mini-extra.enable       = true;
            mini-git.enable         = true;
            mini-icons.enable       = true;
            mini-indentscope.enable = true;
            mini-jump.enable        = true;
            mini-jump2d.enable      = true;
            mini-move.enable        = true;
            mini-notify.enable      = true;
            mini-operators.enable   = true;
            mini-pairs.enable       = true;
            mini-pick.enable        = true;
            mini-splitjoin.enable   = true;
            mini-starter.enable     = true;
            mini-statusline.enable  = true;
            mini-surround.enable    = true;
            mini-tabline.enable     = true;
            mini-trailspace.enable  = true;

            friendly-snippets.enable = true;
            transparent.enable = true;
            neogit.enable = true;
            todo-comments.enable = true;
            origami.enable = true;
            rainbow-delimiters.enable = true;

            render-markdown = {
                enable = true;
                settings = {
                    code = {
                        width = "block";
                        right_pad = 1;
                    };
                };
            };

            treesitter = {
                enable = true;
                settings = {
                    highlight = {
                        enable = true;
                        additional_vim_regex_highlighting = true;
                        disable = lib.nixvim.utils.mkRaw ''function (_, buf)
                                local max_filesize = 1000 * 1024
                                local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
                                if ok and stats and stats.size > max_filesize
                                then
                                    return true
                                end
                            end
                            '';
                    };
                    indent.enable = true;
                    ensure_installed = "all";
                    ignore_install = [
                        "ipkg"
                    ];
                };
                folding = true;

                grammarPackages = [ pkgs.vimPlugins.nvim-treesitter.withAllGrammars ];
            };

            haskell-tools = {
                enable = true;
                settings = {
                    hls = {
                        default_settings = {
                            haskell = {
                                formattingProvider = "fourmolu";
                                plugin = {
                                    hlint = {
                                        codeActionsOn = false;
                                        diagnosticsOn = false;
                                    };
                                    importLens = {
                                        codeActionsOn = false;
                                        codeLensOn = false;
                                        globalOn = false;
                                    };
                                };
                            };
                        };
                    };
                };
            };

            lsp = {
                enable = true;
                keymaps = {
                    silent = true;
                    lspBuf = {
                        gd = "definition";
                        gD = "declaration";
                        K  = "hover";
                        gi = "implementation";
                        "<leader>rn" = "rename";
                        "<leader>ca" = "code_action";
                    };
                };
                servers = {
                    bashls.enable  = true;
                    clangd.enable  = true;
                    jsonls.enable  = true;
                    lua_ls.enable  = true;
                    nixd.enable    = true;
                    sqls.enable    = true;
                    ts_ls.enable   = true;
                    nushell.enable = true;

                    # Rust (Standard setup)
                    rust_analyzer = {
                        enable       = true;
                        installCargo = true;
                        installRustc = true;
                    };
                };
            };

            blink-cmp = {
                enable   = true;
                settings = {
                    keymap.preset     = "default";
                    signature.enabled = true;
                    sources.default   = [
                        "lsp" "path" "snippets" "buffer"
                    ];
                    appearance        = {
                        use_nvim_cmp_as_default = true;
                        nerd_font_variant       = "mono";
                    };
                };
            };
        };

        extraPlugins = [
            pkgs.vimPlugins.stay-centered-nvim
            pkgs.vimPlugins.focus-nvim
        ];

        extraConfigLua = ''
            require "stay-centered" .setup {
                skip_filetypes = {""},
            }

            require "focus" .setup {
                ui = { colorcolumn = { enable = true } }
            }

            local trans = require "transparent"

            if vim.g.neovide then
                trans.toggle(false)
            else
                trans.toggle(true)
            end

            vim.api.nvim_set_hl(0, "MatchParen", { bg = "darkblue" })
        '';

        keymaps = let
            setmap = mode: key: action: options: {
                mode     = mode;
                key      = key;
                action   = action;
                options  = options;
            };
        in [
            (setmap "n" "<leader>qw" "<cmd>wq<CR>"    { desc = "save and quit";               })
            (setmap "n" "<Esc>"      "<cmd>nohl<CR>"  { desc = "No Highlight"; silent = true; })
            (setmap "n" "<C-s>"      "<cmd>write<CR>" { desc = "save";                        })
            (setmap "n" "<leader>w"  "<cmd>write<CR>" { desc = "save";                        })
            (setmap "n" "<leader>cd" "<cmd>Cd<CR>"    { desc = "cd to this file dir";         })

            # Make
            (setmap "n" "<leader>mr"  "<cmd>term make run<CR>"        { desc = "(m)ake (r)un";   })
            (setmap "n" "<leader>mb"  "<cmd>term make build<CR>"      { desc = "(m)ake (b)uild"; })
            (setmap "n" "<leader>mqb" "<cmd>term make build<CR>a<CR>" { desc = "quick build";    })

            (setmap "n" "<leader>rw" '':%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>'' {
                desc = "(r)eplace (w)ord";
            })

            # Open MiniFiles
            (setmap "n" "-" "<cmd>lua MiniFiles.open()<CR>" { desc = "Open parent dir"; })

            # MiniPick
            (setmap "n" "<leader>pb" "<cmd>Pick buffers<CR>"  { desc = "(p)ick (b)uffers"; })
            (setmap "n" "<leader>pf" "<cmd>Pick files<CR>"    { desc = "(p)ick (f)iles";   })
            (setmap "n" "<leader>ph" "<cmd>Pick help<CR>"     { desc = "(p)ick (h)elp";    })
            (setmap "n" "<leader>:"  "<cmd>Pick commands<CR>" { desc = "(p)ick (c)ommand"; })
            (setmap "n" "<leader>po" "<cmd>Pick options<CR>"  { desc = "(p)ick (o)ption";  })

            # NeoGit
            (setmap "n" "<leader>gn" "<cmd>Neogit<CR>" { desc = "open NeoGit"; })

            # Terminals
            (setmap "t" "<C-q>"      "<C-\\><C-n>"         { desc = "quit terminal";  nowait = true; })
            (setmap "n" "<leader>ot" "<cmd>term<CR>a"      { desc = "(o)pen (t)erminal";             })
            (setmap "n" "<leader>vt" "<cmd>vs | term<CR>a" { desc = "(v)ertical pane (t)erminal";    })
            (setmap "n" "<leader>st" "<cmd>sp | term<CR>a" { desc = "horizontal pane (t)erminal";    })

            # using fixlist
            (setmap "n" "<C-k>"     "<cmd>cnext<CR>" { desc = "Next quickfix";     })
            (setmap "n" "<C-j>"     "<cmd>cprev<CR>" { desc = "Previous quickfix"; })
            (setmap "n" "<leader>k" "<cmd>lnext<CR>" { desc = "Next location";     })
            (setmap "n" "<leader>j" "<cmd>lprev<CR>" { desc = "Previous location"; })

            (setmap [ "n" "v" ] "J" "mzJ`z" {
                desc = "shift+j but the cursor stay in place";
            })
            (setmap [ "n" "v" ] "<leader>d" ''"_d'' {
                desc = "delete without saving to register";
            })

            (setmap [ "i" "v" ] "kj" "<Esc>" { desc = "exit to normal"; })
        ];

        autoCmd = let
            mkAuCmd = desc: event: pattern: callback: {
                event    = event;
                pattern  = pattern;
                callback = callback;
                desc     = desc;
            };

            trimOnSafe = lib.nixvim.utils.mkRaw "require('mini.trailspace').trim";

            setupHaskell = lib.nixvim.utils.mkRaw ''
                function()
                    local ht    = require "haskell-tools"
                    local bufnr = vim.api.nvim_get_current_buf()
                    local opt   = { buffer = bufnr }
                    local set   = vim.keymap.set

                    local nset = function(key, cmd, opts)
                        set("n", key, cmd, opts)
                    end

                    ---@param desc string
                    ---@return { buffer: number, desc: string}
                    local desc = function(desc)
                        opt.desc = desc
                        return opt
                    end

                    vim.o.makeprg = "cabal $*"

                    -- Leader-c mappings untuk Cabal
                    nset("<Leader>cb", "<CMD>vs | term cabal build<CR>", desc "Cabal Build")
                    nset("<Leader>cr", "<CMD>vs | term cabal run<CR>",   desc "Cabal Run")
                    nset("<Leader>ct", "<CMD>vs | term cabal test<CR>",  desc "Cabal Test")
                    nset("<Leader>cc", "<CMD>edit *.cabal<CR>",          desc "Open Cabal File")
                    nset(
                        "<leader>ci",
                        "<CMD>vs | term cabal install --installdir=./bin --overwrite-policy=always<CR>",
                        desc "Cabal Install in bin directory"
                    )

                    -- Leader-h mappings untuk Haskell Tools
                    nset("<Leader>hh", ht.hoogle.hoogle_signature, desc "Hoogle Search")
                    nset("<Leader>hr", ht.repl.toggle,             desc "Toggle REPL")
                    nset("<Leader>ht", vim.lsp.buf.hover,          desc "Show Type Signature")
                end
            '';
            pathCrumb = lib.nixvim.utils.mkRaw ''
                function()
                    vim.o.winbar = "%!g:GetShortPath()"
                end
            '';
            signColumn = lib.nixvim.utils.mkRaw ''function()
                if vim.bo.buftype == "" and vim.wo.signcolumn ~= "yes:2" then
                    vim.opt.signcolumn = "yes:2"
                end
            end'';
        in [
            (mkAuCmd "Trim on save" "BufWritePre" "*" trimOnSafe)
            (mkAuCmd "Setup Haskell"
                "FileType"
                [ "haskell" "cabal" "*.hs" "*.cabal" ]
                setupHaskell)
            (mkAuCmd "Path Crumb on winbar"
                [ "BufEnter" "BufWinEnter" ]
                "*"
                pathCrumb)
            (mkAuCmd "Ensure signcolumn is always 'yes:2' in normal buffers"
                "BufEnter"
                "*"
                signColumn)
        ];

        userCommands.Cd = {
            command = "cd %:h";
            nargs   = 0;
            desc = "cd to current opened file";
        };

    };
}
