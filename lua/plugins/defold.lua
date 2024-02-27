-- Detect if the current project is a Defold project
if vim.fn.glob('game.project') ~= '' then
    -- Enable Lua LSP for Defold .script filetypes
    vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
        pattern = { "*.script" },
        callback = function()
            vim.opt.filetype = "lua"
        end,
    })

    -- Enable Go LSP for Defold resource filetypes
    vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
        pattern = { "*.tilemap", "*.tilesource", "*.atlas", "*.collection", "*.input_binding" },
        callback = function()
            vim.opt.filetype = "go"
        end,
    })

    -- Enable TOML LSP for Defold game.project filetypes
    vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
        pattern = { "*.project" },
        callback = function()
            vim.opt.filetype = "toml"
        end,
    })

    local plugin_config = {
        {
            "neovim/nvim-lspconfig",
            opts = {
                servers = {
                    -- Enable Lua LSP for *.script files
                    lua_ls = {
                        root_dir = require("lspconfig.util").root_pattern(".luarc.json", ".luarc.jsonc", ".luacheckrc",
                            ".stylua.toml",
                            "stylua.toml",
                            "selene.toml", "selene.yml", ".git", "game.project")
                    },
                    -- Disable gopls LSP for *.go files
                    gopls = {
                        filetypes = { "gomod", "gowork", "gotmpl" },
                        root_dir = require("lspconfig.util").root_pattern("go.mod", "go.work", ".git", "game.project")
                    },
                },
            },
        },
    }

    -- Configure LSPs for Defold
    return plugin_config
else
    return {}
end
