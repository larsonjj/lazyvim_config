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

    if vim.g.vscode then
        -- Disable problematic plugins for vscode neovim plugin
        plugin_config.insert(
            { "nvim-treesitter/nvim-treesitter", enabled = true },
            { "echasnovski/mini.pairs", enabled = true },
            { "echasnovski/mini.surround", enabled = true },
            { "b0o/SchemaStore.nvim", enabled = false },
            { "simrat39/rust-tools.nvim", enabled = false },
            { "rouge8/neotest-rust", enabled = false },
            { "nvim-lualine/lualine.nvim", enabled = false },
            { "NvChad/nvim-colorizer.lua", enabled = false },
            { "nvim-neotest/neotest-go", enabled = false },
            { "lukas-reineke/indent-blankline.nvim", enabled = true },
            { "neovim/nvim-lspconfig", enabled = false },
            { "echasnovski/mini.comment", enabled = true },
            { "nvim-neo-tree/neo-tree.nvim", enabled = false },
            { "echasnovski/mini.ai", enabled = true },
            { "nvim-pack/nvim-spectre", enabled = false },
            { "nvim-neotest/neotest", enabled = false },
            { "nvim-tree/nvim-web-devicons", enabled = false },
            { "catppuccin/nvim", enabled = false },
            { "ggandor/flit.nvim", enabled = true },
            { "nvim-telescope/telescope-fzf-native.nvim", enabled = false },
            { "MunifTanjim/nui.nvim", enabled = false },
            { "ggandor/leap.nvim", enabled = true },
            { "nvim-treesitter/nvim-treesitter-textobjects", enabled = false },
            { "folke/neoconf.nvim", enabled = false },
            { "goolord/alpha-nvim", enabled = false },
            { "nvim-treesitter/nvim-treesitter-context", enabled = false },
            { "tpope/vim-repeat", enabled = true },
            { "Saecki/crates.nvim", enabled = false },
            { "lewis6991/gitsigns.nvim", enabled = false },
            { "windwp/nvim-ts-autotag", enabled = true },
            { "RRethy/vim-illuminate", enabled = false },
            { "folke/neodev.nvim", enabled = true },
            { "folke/trouble.nvim", enabled = false },
            { "williamboman/mason.nvim", enabled = false },
            { "williamboman/mason-lspconfig.nvim", enabled = false },
            { "folke/noice.nvim", enabled = false },
            { "stevearc/dressing.nvim", enabled = false },
            { "hrsh7th/nvim-cmp", enabled = false })
    end

    -- Configure LSPs for Defold
    return plugin_config
else
    return {}
end
