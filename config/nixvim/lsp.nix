{
  lib,
  pkgs,
  ...
}:
{
  lsp = {
    inlayHints.enable = true;
    servers.lua_ls.config = {
      on_init = lib.nixvim.utils.mkRaw ''
        function(client)
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
        Lua = { };
      };
    };
  };

  plugins.lsp = {
    enable = true;
    keymaps = {
      silent = true;
      lspBuf = {
        gd = "definition";
        gD = "declaration";
        K = "hover";
        gi = "implementation";
        "<leader>rn" = "rename";
        "<leader>ca" = "code_action";
      };
    };
    servers = {
      bashls.enable = true;
      clangd.enable = true;
      lua_ls.enable = true;
      # ocamllsp.enable = true;
      nixd.enable = true;
      nushell.enable = true;
      sqls.enable = true;

      uiua.enable = true;
      uiua.config.filetypes = [ "uiua" ];

      taplo.enable = true;

      idris2_ls = {
        enable = true;
        # Memaksa LSP dijalankan melalui pack
        config = {
          cmd = [
            "pack"
            "exec"
            "idris2-lsp"
          ];
        };
      };

      # ESLint LSP Server untuk JavaScript/TypeScript
      eslint = {
        enable = true;
        filetypes = [
          "javascript"
          "javascriptreact"
          "typescript"
          "typescriptreact"
          "vue"
          "svelte"
        ];
        settings = {
          codeAction = {
            disableRuleComment = {
              enable = true;
              location = "separateLine";
            };
            showDocumentation = {
              enable = true;
            };
          };
          codeActionOnSave = {
            enable = true;
            mode = "all";
          };
          format = false;
          nodePath = "";
          quiet = false;
          rulesCustomizations = { };
          run = "onType";
          validate = "on";
          workingDirectory = {
            mode = "location";
          };
        };
      };

      # Stylelint LSP Server untuk CSS/SCSS
      stylelint_lsp = {
        enable = true;
        filetypes = [
          "css"
          "scss"
          "less"
          "sass"
          "stylus"
          "vue"
          "svelte"
        ];
        cmd = [
          "${pkgs.stylelint-lsp}/bin/stylelint-lsp"
          "--stdio"
        ];
        settings = {
          stylelintplus = {
            autoFixOnFormat = true;
            autoFixOnSave = true;
            cssInJs = {
              injectedLanguages = [
                "javascript"
                "typescript"
              ];
            };
          };
        };
      };

      jsonls = {
        enable = true;
        filetypes = [
          "json"
          "jsonc"
        ];
        settings = {
          json = {
            validate = {
              enable = true;
            };
            schemas = [
              {
                fileMatch = [ "package.json" ];
                url = "https://json.schemastore.org/package";
              }
              {
                fileMatch = [ "tsconfig*.json" ];
                url = "https://json.schemastore.org/tsconfig";
              }
              {
                fileMatch = [ "jsconfig*.json" ];
                url = "https://json.schemastore.org/jsconfig";
              }
              {
                fileMatch = [ ".eslintrc.json" ];
                url = "https://json.schemastore.org/eslintrc";
              }
              {
                fileMatch = [ "prettierrc.json" ];
                url = "https://json.schemastore.org/prettierrc";
              }
              {
                fileMatch = [ ".stylelintrc.json" ];
                url = "https://json.schemastore.org/stylelintrc";
              }
              {
                fileMatch = [ "babel.config.json" ];
                url = "https://json.schemastore.org/babelrc";
              }
            ];
          };
        };
      };

      # Rust (Standard setup)
      # rust_analyzer = {
      #     enable = true;
      #     installCargo = true;
      #     installRustc = true;
      # };
    };
  };

  plugins.rustaceanvim = {
    enable = true;
    settings.server.default_settings.rust-analyzer = {
      checkOnSave = true;
      cargo.features = "all";
      procMacro.enable = true;
    };
  };
}
