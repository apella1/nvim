return {
    "neovim/nvim-lspconfig",
    dependencies = {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
    },
    config = function()
        local lspconfig = require("lspconfig")
        local capabilities = require('cmp_nvim_lsp').default_capabilities()

        -- Common LSP settings
        local on_attach = function(client, bufnr)
            -- Enable completion triggered by <c-x><c-o>
            vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

            -- Buffer local mappings
            local opts = { noremap = true, silent = true, buffer = bufnr }
            
            -- Navigation
            vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
            vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
            vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
            vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
            vim.keymap.set('n', 'gt', vim.lsp.buf.type_definition, opts)
            
            -- Documentation
            vim.keymap.set('n', 'gh', vim.lsp.buf.hover, opts)
            vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
            
            -- Actions
            vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
            vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)
            
            -- Diagnostics
            vim.keymap.set('n', 'gl', vim.diagnostic.open_float, opts)
            vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
            vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
        end

        -- Make sure capabilities are properly set
        capabilities = vim.tbl_deep_extend('force', capabilities or {}, {
            textDocument = {
                completion = {
                    completionItem = {
                        snippetSupport = true,
                        preselectSupport = true,
                        insertReplaceSupport = true,
                        labelDetailsSupport = true,
                        deprecatedSupport = true,
                        commitCharactersSupport = true,
                        documentationFormat = { 'markdown', 'plaintext' },
                        preselectSupport = true
                    }
                }
            }
        })

        -- TypeScript/JavaScript
        lspconfig.tsserver.setup({
            on_attach = on_attach,
            capabilities = capabilities,
            root_dir = lspconfig.util.root_pattern("package.json", "tsconfig.json", "jsconfig.json"),
            single_file_support = false,
            settings = {
                typescript = {
                    inlayHints = {
                        includeInlayParameterNameHints = "all",
                        includeInlayParameterNameHintsWhenArgumentMatchesName = false,
                        includeInlayFunctionParameterTypeHints = true,
                        includeInlayVariableTypeHints = true,
                        includeInlayPropertyDeclarationTypeHints = true,
                        includeInlayFunctionLikeReturnTypeHints = true,
                        includeInlayEnumMemberValueHints = true,
                    }
                },
                javascript = {
                    inlayHints = {
                        includeInlayParameterNameHints = "all",
                        includeInlayParameterNameHintsWhenArgumentMatchesName = false,
                        includeInlayFunctionParameterTypeHints = true,
                        includeInlayVariableTypeHints = true,
                        includeInlayPropertyDeclarationTypeHints = true,
                        includeInlayFunctionLikeReturnTypeHints = true,
                        includeInlayEnumMemberValueHints = true,
                    }
                }
            }
        })

        -- HTML
        lspconfig.html.setup({
            on_attach = on_attach,
            capabilities = capabilities,
        })

        -- CSS
        lspconfig.cssls.setup({
            on_attach = on_attach,
            capabilities = capabilities,
        })

        -- ESLint
        lspconfig.eslint.setup({
            on_attach = function(client, bufnr)
                on_attach(client, bufnr)
                -- Auto-fix on save
                vim.api.nvim_create_autocmd("BufWritePre", {
                    buffer = bufnr,
                    command = "EslintFixAll",
                })
            end,
        })

        -- Tailwind CSS
        lspconfig.tailwindcss.setup({
            on_attach = on_attach,
            filetypes = { 
                -- Extend default filetypes
                "aspnetcorerazor", 
                "astro",
                "astro-markdown",
                "blade",
                "clojure",
                "django-html",
                "htmldjango",
                "edge",
                "eelixir",
                "elixir",
                "ejs",
                "erb",
                "eruby",
                "gohtml",
                "gohtmltmpl",
                "haml",
                "handlebars",
                "hbs",
                "html",
                "html-eex",
                "heex",
                "jade",
                "leaf",
                "liquid",
                "markdown",
                "mdx",
                "mustache",
                "njk",
                "nunjucks",
                "php",
                "razor",
                "slim",
                "twig",
                "css",
                "less",
                "postcss",
                "sass",
                "scss",
                "stylus",
                "sugarss",
                "javascript",
                "javascriptreact",
                "reason",
                "rescript",
                "typescript",
                "typescriptreact",
                "vue",
                "svelte",
            },
            init_options = {
                userLanguages = {
                    eelixir = "html-eex",
                    eruby = "erb",
                },
            },
            settings = {
                tailwindCSS = {
                    experimental = {
                        classRegex = {
                            "tw`([^`]*)",       -- tw`...`
                            'tw="([^"]*)',      -- <div tw="..." />
                            'tw={"([^"}]*)',    -- <div tw={"..."} />
                            "tw\\.\\w+`([^`]*)", -- tw.xxx`...`
                            "tw\\(.*?\\)`([^`]*)", -- tw(..)`...`
                        },
                    },
                    includeLanguages = {
                        typescript = "javascript",
                        typescriptreact = "javascript",
                        ["javascript.jsx"] = "javascript",
                        ["typescript.tsx"] = "javascript",
                    },
                    validate = true,
                },
            },
        })
    end,
}
