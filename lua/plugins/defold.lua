-- Enable Lua LSP for Defold .script filetypes
vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
    pattern = { "*.script" },
    callback = function()
        vim.opt.filetype = "lua"
    end,
})

-- Enable Proto LSP for Defold resource filetypes
vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
    pattern = { "*.tilemap", "*.tilesource", "*.atlas", "*.collection", "*.input_binding" },
    callback = function()
        vim.opt.filetype = "proto"
    end,
})

-- Enable TOML LSP for Defold game.project filetypes
vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
    pattern = { "*.project" },
    callback = function()
        vim.opt.filetype = "toml"
    end,
})

-- Enable Lua LSP for Defold Projects
return {
    "neovim/nvim-lspconfig",
    opts = {
        servers = {
            lua_ls = {
                root_dir = require("lspconfig.util").root_pattern(".luarc.json", ".luarc.jsonc", ".luacheckrc",
                    ".stylua.toml",
                    "stylua.toml",
                    "selene.toml", "selene.yml", ".git", "game.project")
            },
            clangd = {
                capabilities = {
                    textDocument = {
                        completion = {
                            editsNearCursor = true,
                        },
                    },
                    offsetEncoding = { 'utf-8', 'utf-16' },
                },
                filetypes = { "c", "cpp", "objc", "objcpp", "cuda" },
                root_dir = require("lspconfig.util").root_pattern(".clangd",
                    ".clang-tidy",
                    ".clang-format",
                    "compile_commands.json",
                    "compile_flags.txt",
                    "configure.ac",
                    ".git",
                    "game.project")
            },
        },
    },
}
