{ pkgs, lib, ... }:
{
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

        mini-ai.enable = true;
        mini-align.enable = true;
        mini-bracketed.enable = true;
        mini-comment.enable = true;
        mini-completion.enable = false;
        mini-cursorword.enable = true;
        mini-diff.enable = true;
        mini-doc.enable = true;
        mini-extra.enable = true;
        mini-git.enable = true;
        mini-icons.enable = true;
        mini-indentscope.enable = true;
        mini-jump.enable = true;
        mini-jump2d.enable = true;
        mini-move.enable = true;
        mini-notify.enable = true;
        mini-operators.enable = true;
        mini-pairs.enable = true;
        mini-pick.enable = true;
        mini-splitjoin.enable = true;
        mini-starter.enable = true;
        mini-statusline.enable = true;
        mini-surround.enable = true;
        mini-tabline.enable = true;
        mini-trailspace.enable = true;

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
                    disable = lib.nixvim.utils.mkRaw ''
                        function (_, buf)
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
                                    codeActionsOn = true;
                                    diagnosticsOn = true;
                                };
                                importLens = {
                                    codeActionsOn = true;
                                    codeLensOn = true;
                                    globalOn = true;
                                };
                            };
                        };
                    };
                };
            };
        };

        idris2.enable = true;

        blink-cmp = {
            enable = true;
            settings = {
                keymap.preset = "default";
                signature.enabled = true;
                sources.default = [
                    "lsp"
                    "path"
                    "snippets"
                    "buffer"
                ];
                appearance = {
                    use_nvim_cmp_as_default = true;
                    nerd_font_variant = "mono";
                };
            };
        };
    };
}
