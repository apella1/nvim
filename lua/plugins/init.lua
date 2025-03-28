-- Each plugin specification
local plugins = {
    {
        "nvim-tree/nvim-tree.lua",
        version = "*",
        lazy = false,
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
            require("plugins.nvim-tree")
        end,
    },
    { "tpope/vim-surround" },
    { "tpope/vim-commentary" },
    {
        "nvim-telescope/telescope.nvim",
        tag = "0.1.4",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function()
            require("plugins.telescope")
        end,
    },
    { "nvim-treesitter/nvim-treesitter" },
    {
        "nvim-lualine/lualine.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
            require("plugins.lualine")
        end,
    },
    {
        "Mofiqul/dracula.nvim",
        lazy = false,
        priority = 1000,
        config = function()
            require("plugins.colorscheme")
        end,
    },
    { "wakatime/vim-wakatime", lazy = false },
    {
        "williamboman/mason.nvim",
        opts = {
            ensure_installed = {
                "gh",
                "lua_ls",
                "lua-language-server",
                "luacheck",
                "luaformatter",
                "markdownlint",
                "cspell",
            },
        },
    },
    { "williamboman/mason-lspconfig.nvim" },
}

return plugins

