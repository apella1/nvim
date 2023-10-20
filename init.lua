--  setting up nvim tree
-- disable netrw at the very start of your init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Set the leader key to space
vim.api.nvim_set_keymap("", "<Space>", "<Nop>", { noremap = true, silent = true })
vim.g.mapleader = " " -- Define space as the leader key

-- Set line numbers and relative line numbers
vim.wo.number = true
vim.wo.relativenumber = true

-- Set tab width and tab stop
vim.bo.tabstop = 4
vim.bo.softtabstop = 4
vim.bo.shiftwidth = 4

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
local uv = vim.uv or vim.loop

-- Auto-install lazy.nvim if not present
if not uv.fs_stat(lazypath) then
	print("Installing lazy.nvim....")
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
	print("Done.")
end

vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	-- Linter
	{ "mfussenegger/nvim-lint" },
	-- Formatter
	{ "mhartington/formatter.nvim" },

	{ "lukas-reineke/indent-blankline.nvim", main = "ibl", opts = {} },
	-- nvim tree

	{
		"nvim-tree/nvim-tree.lua",
		version = "*",
		lazy = false,
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			require("nvim-tree").setup({})
		end,
	},
	{ "tpope/vim-surround" },
	{ "tpope/vim-commentary" },
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.4",
		-- or                              , branch = '0.1.x',
		dependencies = { "nvim-lua/plenary.nvim" },
	},
	{ "nvim-treesitter/nvim-treesitter" },
	-- lua line
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
	},
	-- Dracula
	{ "Mofiqul/dracula.nvim", lazy = false },
	{ "wakatime/vim-wakatime", lazy = false },
	{
		"williamboman/mason.nvim",
		opts = {
			ensure_installed = {
				"gh",
				"gitleaks",
				"lua_ls",
				"lua-language-server",
				"luacheck",
				"luaformatter",
				"rust_analyzer",
				"rustfmt",
				"black",
				"ruff",
				"mypy",
				"pyright",
				"eslint_d",
				"tailwindcss-language-server",
				"rustywind",
				"emmet-ls",
				"jsonlint",
				"markdownlint",
				"prettier",
				"prettierd",
				"cspell",
				"djlint",
				"html-lsp",
				"css-lsp",
				"cssmodules-language-server",
				"autoflake",
				"sqlls",
				"commitlint",
				"docformatter",
			},
		},
	},
	{ "williamboman/mason-lspconfig.nvim" },
	-- LSP Support
	{
		"VonHeikemen/lsp-zero.nvim",
		branch = "v3.x",
		lazy = true,
		config = false,
	},
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			{ "hrsh7th/cmp-nvim-lsp" },
		},
	},
	-- Autocompletion
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			{ "L3MON4D3/LuaSnip" },
		},
	},
})

-- Colorscheme config
-- Should be run before colorscheme setup
local dracula = require("dracula")
dracula.setup({
	-- customize dracula color palette
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
	-- show the '~' characters after the end of buffers
	show_end_of_buffer = true, -- default false
	-- use transparent background
	transparent_bg = false, -- default false
	-- set custom lualine background color
	lualine_bg_color = "#44475a", -- default nil
	-- set italic comment
	italic_comment = true, -- default false
	-- overrides the default highlights with table see `:h synIDattr`
	overrides = {},
	-- You can use overrides as table like this
	-- overrides = {
	--   NonText = { fg = "white" }, -- set NonText fg to white
	--   NvimTreeIndentMarker = { link = "NonText" }, -- link to NonText highlight
	--   Nothing = {} -- clear highlight of Nothing
	-- },
	-- Or you can also use it like a function to get color from theme
	-- overrides = function (colors)
	--   return {
	--     NonText = { fg = colors.white }, -- set NonText fg to white of theme
	--   }
	-- end,
})

vim.opt.termguicolors = true
vim.cmd([[colorscheme dracula]])
-- vim.cmd.colorscheme("dracula")

-- Configuring lsp zero
local lsp_zero = require("lsp-zero")

lsp_zero.on_attach(function(client, bufnr)
	-- see :help lsp-zero-keybindings
	-- to learn the available actions
	lsp_zero.default_keymaps({ buffer = bufnr })
end)

-- Setting up mason
require("mason").setup({})

require("mason-lspconfig").setup({
	handlers = {
		lsp_zero.default_setup,
	},
	ensure_installed = {
		"lua_ls",
		"rust_analyzer",
		"pyright",
		"cssmodules_ls",
		"cssls",
		"denols",
		"eslint",
		"emmet_ls",
		"grammarly",
		"graphql",
		"html",
		"biome",
		"tsserver",
		"ruff_lsp",
		"sqlls",
		"taplo",
	},
})

-- Configuring different lsps (requiring special configs)
-- setup_servers({"tsserver", "etc"}) - no configs
require("lspconfig").tsserver.setup({})
require("lspconfig").rust_analyzer.setup({})
-- require("lspconfig").black.setup({})
-- require("lspconfig").cspell.setup({})
-- require("lspconfig").djlint.setup({})
require("lspconfig").emmet_ls.setup({})
require("lspconfig").tailwindcss.setup({})
require("lspconfig").cssls.setup({})
-- require("lspconfig").prettier.setup({})
-- require("lspconfig").ruff.setup({})
-- require("lspconfig").markdownlint.setup({})

-- Starting lua line
require("lualine").setup()

--  Nvim tree with defaults
local function my_on_attach(bufnr)
	local api = require("nvim-tree.api")
	local function opts(desc)
		return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
	end

	-- default mappings
	api.config.mappings.default_on_attach(bufnr)

	-- custom mappings
	vim.keymap.set("n", "<C-t>", api.tree.change_root_to_parent, opts("Up"))
	vim.keymap.set("n", "?", api.tree.toggle_help, opts("Help"))
end

require("nvim-tree").setup({
	on_attach = my_on_attach,
})

-- Indent blackline
require("ibl").setup()

-- Adding customized keybindings
local cmp = require("cmp")
local cmp_action = require("lsp-zero").cmp_action()

cmp.setup({
	mapping = cmp.mapping.preset.insert({
		-- `Enter` key to confirm completion
		["<CR>"] = cmp.mapping.confirm({ select = false }),

		-- Ctrl+Space to trigger completion menu
		["<C-Space>"] = cmp.mapping.complete(),

		-- Navigate between snippet placeholder
		["<C-f>"] = cmp_action.luasnip_jump_forward(),
		["<C-b>"] = cmp_action.luasnip_jump_backward(),

		-- Scroll up and down in the completion documentation
		["<C-u>"] = cmp.mapping.scroll_docs(-4),
		["<C-d>"] = cmp.mapping.scroll_docs(4),
	}),
})

-- Telescope mappings
local builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>ff", builtin.find_files, {})
vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})
vim.keymap.set("n", "<leader>fb", builtin.buffers, {})
vim.keymap.set("n", "<leader>fh", builtin.help_tags, {})

-- Configuring linters
require("lint").linters_by_ft = {
	markdown = { "vale" },
	javascript = { "eslint" },
	typescript = { "eslint" },
	python = { "pyright" },
}

-- Setting up autocmd to trigger linting
vim.api.nvim_create_autocmd({ "BufWritePost" }, {
	callback = function()
		require("lint").try_lint()
	end,
})

-- Configuring formatter
-- Utilities for creating configurations
local util = require("formatter.util")

-- Provides the Format, FormatWrite, FormatLock, and FormatWriteLock commands
require("formatter").setup({
	-- Enable or disable logging
	logging = true,
	-- Set the log level
	log_level = vim.log.levels.WARN,
	-- All formatter configurations are opt-in
	filetype = {
		-- Formatter configurations for filetype "lua" go here
		-- and will be executed in order
		lua = {
			-- "formatter.filetypes.lua" defines default configurations for the
			-- "lua" filetype
			require("formatter.filetypes.lua").stylua,

			-- You can also define your own configuration
			function()
				-- Supports conditional formatting
				if util.get_current_buffer_file_name() == "special.lua" then
					return nil
				end

				-- Full specification of configurations is down below and in Vim help
				-- files
				return {
					exe = "stylua",
					args = {
						"--search-parent-directories",
						"--stdin-filepath",
						util.escape_path(util.get_current_buffer_file_path()),
						"--",
						"-",
					},
					stdin = true,
				}
			end,
		},
		javascript = {
			require("formatter.filetypes.javascript").prettier,
		},
		typescript = {
			require("formatter.filetypes.typescript").prettier,
		},
		python = {
			require("formatter.filetypes.python").black,
		},

		-- Use the special "*" filetype for defining formatter configurations on
		-- any filetype
		["*"] = {
			-- "formatter.filetypes.any" defines default configurations for any
			-- filetype
			require("formatter.filetypes.any").remove_trailing_whitespace,
		},
	},
})

vim.api.nvim_create_autocmd({ "BufWritePost" }, {
	command = "FormatWriteLock",
})
