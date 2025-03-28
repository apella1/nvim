return {
    "nvim-tree/nvim-tree.lua",
    version = "*",
    lazy = true,  -- Changed to true to lazy load
    dependencies = {
        "nvim-tree/nvim-web-devicons",
    },
    config = function()
        -- Folder and file icons configuration
        require("nvim-web-devicons").setup({
            folder = {
                enable = true,
                default = "",
                open = "",
                empty = "",
                empty_open = "",
            },
        })

        local function my_on_attach(bufnr)
            local api = require("nvim-tree.api")
            local function opts(desc)
                return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
            end

            api.config.mappings.default_on_attach(bufnr)

            vim.keymap.set("n", "<C-t>", api.tree.change_root_to_parent, opts("Up"))
            vim.keymap.set("n", "?", api.tree.toggle_help, opts("Help"))
        end

        require("nvim-tree").setup({
            on_attach = my_on_attach,
            disable_netrw = true,
            hijack_netrw = true,
            auto_close = true,
            open_on_tab = false,
            hijack_cursor = false,
            update_cwd = true,
            hijack_directories = {
                enable = true,
                auto_open = false,  -- Don't auto-open tree
            },
            diagnostics = {
                enable = true,
                icons = {
                    hint = "",
                    info = "",
                    warning = "",
                    error = "",
                },
            },
            -- File and folder rendering
            renderer = {
                add_trailing = false,
                group_empty = false,
                highlight_git = true,
                full_name = false,
                highlight_opened_files = "none",
                highlight_modified = "none",
                root_folder_label = ":~:s?$?/..?",
                indent_width = 2,
                indent_markers = {
                    enable = true,
                    inline_arrows = true,
                    icons = {
                        corner = "└",
                        edge = "│",
                        item = "│",
                        bottom = "─",
                        none = " ",
                    },
                },
                icons = {
                    webdev_colors = true,
                    git_placement = "before",
                    modified_placement = "after",
                    padding = " ",
                    symlink_arrow = " ➛ ",
                    show = {
                        file = true,
                        folder = true,
                        folder_arrow = true,
                        git = true,
                        modified = true,
                    },
                    glyphs = {
                        default = "",
                        symlink = "",
                        bookmark = "",
                        modified = "●",
                        folder = {
                            arrow_closed = "",
                            arrow_open = "",
                            default = "",
                            open = "",
                            empty = "",
                            empty_open = "",
                            symlink = "",
                            symlink_open = "",
                        },
                        git = {
                            unstaged = "✗",
                            staged = "✓",
                            unmerged = "",
                            renamed = "➜",
                            untracked = "★",
                            deleted = "",
                            ignored = "◌",
                        },
                    },
                },
            },
            -- File and folder filtering
            filters = {
                dotfiles = false,
                git_clean = false,
                no_buffer = false,
                custom = { "node_modules", "\\.cache" },
                exclude = {},
            },
            -- Git integration
            git = {
                enable = true,
                ignore = true,
                show_on_dirs = true,
                timeout = 400,
            },
            -- Modified files indication
            modified = {
                enable = true,
                show_on_dirs = true,
                show_on_open_dirs = true,
            },
        })
    end,
}
