{ lib, ... }:
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
            jsonls.enable = true;
            lua_ls.enable = true;
            nixd.enable = true;
            sqls.enable = true;
            ts_ls.enable = true;
            nushell.enable = true;

            # Rust (Standard setup)
            rust_analyzer = {
                enable = true;
                installCargo = true;
                installRustc = true;
            };
        };
    };
}
