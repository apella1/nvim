-- Each plugin specification
return {
    {
        "Mofiqul/dracula.nvim",
        lazy = false,    -- Load immediately
        priority = 1000, -- Ensure it loads first
        config = function()
            -- Configure dracula
            local dracula = require("dracula")
            dracula.setup({
                colors = {
                    bg = "#282A36",
                    fg = "#F8F8F2",
                    selection = "#44475A",
                    comment = "#6272A4",
                    red = "#FF5555",
                    orange = "#FFB86C",
                    yellow = "#F1FA8C",
                    green = "#50fa7b",
                    purple = "#BD93F9",
                    cyan = "#8BE9FD",
                    pink = "#FF79C6",
                    bright_red = "#FF6E6E",
                    bright_green = "#69FF94",
                    bright_yellow = "#FFFFA5",
                    bright_blue = "#D6ACFF",
                    bright_magenta = "#FF92DF",
                    bright_cyan = "#A4FFFF",
                    bright_white = "#FFFFFF",
                    menu = "#21222C",
                    visual = "#3E4452",
                    gutter_fg = "#4B5263",
                    nontext = "#3B4048",
                    white = "#ABB2BF",
                    black = "#191A21",
                },
                show_end_of_buffer = true,
                transparent_bg = false,
                lualine_bg_color = "#44475a",
                italic_comment = true,
                overrides = {},
            })

            -- Set the colorscheme
            vim.cmd([[colorscheme dracula]])
        end,
    },
    {
        "nvim-tree/nvim-web-devicons",
        lazy = false,
    },
    {
        "nvim-lualine/lualine.nvim",
        dependencies = {
            "nvim-tree/nvim-web-devicons",
            "Mofiqul/dracula.nvim"
        },
        config = function()
            require("lualine").setup({
                options = {
                    theme = 'dracula'
                }
            })
        end,
    },
    {
        "nvim-tree/nvim-tree.lua",
        version = "*",
        lazy = false,
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
            require("plugins.nvim-tree")
        end,
    },
    {
        "nvim-telescope/telescope.nvim",
        tag = "0.1.4",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function()
            require("plugins.telescope")
        end,
    },
    { "nvim-treesitter/nvim-treesitter" },
    { "tpope/vim-surround" },
    { "tpope/vim-commentary" },
    { "wakatime/vim-wakatime",          lazy = false },
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
